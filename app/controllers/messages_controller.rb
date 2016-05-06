require 'net/pop'

class MessagesController < ApplicationController

  before_action :get_config_email

  def new
    @message = Message.new
    @from = @config_emails.username
    @message_attachment = @message.message_attachments.build
  end

  def create
    @message = Message.new(message_params.merge(date: DateTime.now.to_date, from: @config_emails.username, config_email_id: @config_emails.id))
    @message.write!
    if @message.save
      unless params[:message_attachments].nil?
        params[:message_attachments]['file'].each do |a|
          @message_attachment = @message.message_attachments.create!(:file => a)
        end
      end
      UserMailer.send_email(@message, @config_emails).deliver
      redirect_to write_emails_path
      flash[:info] = "Your message was sent!"
    else
      render "new"
    end
  end

  def destroy_emails
    @messages = Message.find(params[:messages_ids])
    @messages.each do |message|
      message.destroy
    end
    # flash[:info] = "Your message was destroy!"
    render status: 200, :json => {}
  end

  def trash
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      redirect_to new_config_email_path
      flash[:warning] = "Please connect your email address!!!"
    else
      @messages = @config_emails.messages.where(trash: true)
    end
  end

  def read_emails
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      redirect_to new_config_email_path
      flash[:warning] = "Please connect your email address!!!"
    else
      @messages = @config_emails.messages.where(status: 0, trash: false)
      @messages = @messages.read_by(current_vendor)
    end
  end

  def inbox
    config_emails = current_vendor.config_emails
    if @config_emails.nil?
      redirect_to new_config_email_path
      flash[:warning] = "Please connect your email address!!!"
    else
      begin
        config_emails.each do |config_email|
          Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
          Net::POP3.start('pop.' + "#{config_email.server_email}", 995, config_email.username, decryption(config_email.password_encrypted)) do |pop|
            if pop.mails.empty?
              puts 'No mails.'
            else
              pop.each_mail do |mail|
                UserMailer.current_vendor_config_email(config_email)
                UserMailer.receive(mail.pop)
                mail.delete
              end
              pop.finish
            end
          end
        end
      rescue Exception => e
        puts ("#{e.message}")
        @exc = e.message
        flash[:warning] = 'Error' + "#{@exc}"
      end
      @messages = @config_emails.messages.where(status: 0, trash: false)
    end
  end

  def write_emails
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      redirect_to new_config_email_path
      flash[:warning] = "Please connect your email address!!!"
    else
      @messages = @config_emails.messages.where(status: 1, trash: false)
    end
  end

  def show_message_read
    @message = Message.find(params[:id])
    @message.mark_as_read! :for => current_vendor

    # @to =
    # @message_reply_to = Message.new(message_params.merge(date: DateTime.now.to_date, from: @config_emails.username, config_email_id: @config_emails.id))
    # if @message_reply_to.save
    #   UserMailer.send_email(@message_reply_to, @config_emails).deliver
    #   redirect_to write_emails_path
    #   flash[:info] = "Your message was sent!"
    # else
    #   render "form_reply_to"
    # end

  end

  def show_message_write
    @message = Message.find(params[:id])
    @message.mark_as_read! :for => current_vendor
  end

  def move_to_trash
    @messages = Message.find(params[:messages_ids])
    @messages.each do |message|
      message.update(trash: true)
    end
    # flash[:info] = "Your message was move to trash!"
    render status: 200, :json => {}

  end

  private

  def message_params
    params.require(:message).permit(:to, :from, :body, :subject, :date, :status, :config_email_id, {message_attachments: []})
  end

  def decryption(password)
    cipher = OpenSSL::Cipher.new('AES-128-ECB')
    cipher.decrypt()
    cipher.key = ENV["key_encrypt_decrypt"]
    tempkey = Base64.decode64(password)
    crypt = cipher.update(tempkey)
    crypt << cipher.final()
    return crypt
  rescue Exception => exc
    puts ("Message for the decryption log file for message #{password} = #{exc.message}")
  end

  # Before filters

  def get_config_email
    @config_emails = current_vendor.config_emails.first
  end

end



