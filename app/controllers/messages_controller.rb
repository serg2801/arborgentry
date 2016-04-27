require 'net/pop'

class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]

  def new
    @message = Message.new
    config_emails = current_vendor.config_emails.last
    @from = config_emails.username
  end

  def create
    config_emails = current_vendor.config_emails.last
    @message = Message.new(message_params.merge(date: DateTime.now.to_date, from: config_emails.username, config_email_id: config_emails.id))
    # binding.pry
    @message.write!
    if @message.save
      UserMailer.send_email(@message, config_emails).deliver
      # redirect_to show_message_write_path(:id => @message.id)
      redirect_to write_emails_path
      flash[:notice] = "Your message was sent!"
    else
      render "new"
    end
  end

  def destroy
    if @message.destroy
      redirect_to messages_path
      flash[:notice] = "Your message was deleted!"
    end
  end

  def read_emails
    @emails = current_vendor.config_emails
    @config_emails = current_vendor.config_emails.first
    #@messages = @config_emails.messages
    @messages = @config_emails.messages.where(status: 0)
    @messages = @messages.read_by(current_vendor)

    get_emails(@emails)
  end

  def inbox
    @emails = current_vendor.config_emails
    @config_emails = current_vendor.config_emails.first
    #@messages = @config_emails.messages
    @messages = @config_emails.messages.where(status: 0)

    get_emails(@emails)
  end

  def write_emails
    @emails = current_vendor.config_emails
    @config_emails = current_vendor.config_emails.last
    #@messages = @config_emails.messages
    @messages = @config_emails.messages.where(status: 1)
  end

  def show_message_read
    @message = Message.find(params[:id])
    @message.mark_as_read! :for => current_vendor
  end

  def show_message_write
    @message = Message.find(params[:id])
    @message.mark_as_read! :for => current_vendor
  end

  private

  # Before filters

  def set_message
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:to, :from, :body, :subject, :date, :status, :config_email_id)
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

  def get_emails(config_emails)
    config_emails.each do |config_email|
      Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
      Net::POP3.start('pop.' + "#{config_email.server_email}", 995, config_email.username, decryption(config_email.password_encrypted)) do |pop|
        if pop.mails.empty?
          puts 'No mails.'
        else
          pop.each_mail do |mail|
            UserMailer.receive(mail.pop)
            mail.delete
          end
          pop.finish
        end
      end
    end
  end


end

# @config_emails = ConfigEmail.all
# @config_emails.each do |config_email|
#   Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
#   Net::POP3.start('pop.' + "#{config_email.server_email}", 995, config_email.username, decryption(config_email.password_encrypted)) do |pop|
#     if pop.mails.empty?
#       puts 'No mails.'
#     else
#       pop.each_mail do |mail|
#         UserMailer.receive(mail.pop)
#         mail.delete
#       end
#       pop.finish
#     end
#   end
# end



