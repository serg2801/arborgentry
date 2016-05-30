require 'net/pop'

class MessagesController < ApplicationController

  before_action :get_config_email
  before_action :count_messages, only: [ :inbox, :trash, :read_emails, :write_emails, :new, :show_message_read, :show_message_write ]

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
      flash[:info] = "Your message was sent!"
      redirect_to write_emails_path
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
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(trash: true)
    end
  end

  def read_emails
    @emails = current_vendor.config_emails
    if @config_emails.blank?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(status: 0, trash: false)
      @messages = @messages.read_by(current_vendor)
    end
  end

  def inbox
    if @config_emails.blank?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      begin
        current_vendor.receive_emails
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
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
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



  # Before filters

  def get_config_email
    @config_emails = current_vendor.config_emails.first
  end

  def count_messages
    if @config_emails.nil?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @config_emails = current_vendor.config_emails.first
      @write_messages = @config_emails.messages.where(status: 1, trash: false).count
      @inbox_messages = @config_emails.messages.where(status: 0, trash: false).count
      @trash_messages = @config_emails.messages.where(trash: true).count
    end
  end

end



