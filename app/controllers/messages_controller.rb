require 'net/pop'
require 'net/imap'

class MessagesController < ApplicationController

  alias_method :current_user, :current_vendor
  before_action :do_authorize
  before_action :get_config_email
  before_action :count_messages, only: [:inbox, :trash, :read_emails, :write_emails, :new, :show_message_read, :show_message_write, :starred, :important]
  

  def new
    @message = Message.new
    @from = @config_emails.username
    @message_attachment = @message.message_attachments.build
  end

  def create
    @message = Message.new(message_params.merge(date: DateTime.now, from: @config_emails.username, config_email_id: @config_emails.id))
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
    @trash_messages = @config_emails.messages.where(trash: true).count
    render status: 200, :json => {count_trash: @trash_messages}
  end

  def trash
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(trash: true).order("date desc").page(params[:page]).per(20)
    end
  end

  def read_emails
    @emails = current_vendor.config_emails
    if @config_emails.blank?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(status: 0, trash: false).read_by(current_vendor).order("date desc").page(params[:page]).per(20)
      # @messages = @messages.read_by(current_vendor)
    end
  end

  def inbox
    if @config_emails.blank?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      begin
        if @config_emails.server_name == "POP"
          current_vendor.receive_emails_pop
        else
          current_vendor.receive_emails_imap
        end
      rescue Exception => e
        puts ("#{e.message}")
        @exc = e.message
        flash[:warning] = 'Error' + "#{@exc}"
      end
      @messages = @config_emails.messages.where(status: 0, trash: false).order("date desc").page(params[:page]).per(20)
    end
    @inbox_messages = @config_emails.messages.where(status: 0, trash: false).count
  end

  def refresh_inbox
    if @config_emails.blank?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      begin
        if @config_emails.server_name == "POP"
          current_vendor.receive_emails_pop
        else
          current_vendor.receive_emails_imap
        end
      rescue Exception => e
        puts ("#{e.message}")
        @exc = e.message
        flash[:warning] = 'Error' + "#{@exc}"
      end
      @messages = @config_emails.messages.where(status: 0, trash: false).order("date desc").page(params[:page]).per(20)
    end
    @inbox_messages = @config_emails.messages.where(status: 0, trash: false).count
    render status: 200, :json => {}
  end

  def write_emails
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(status: 1, trash: false).order("date desc").page(params[:page]).per(20)
    end
  end

  def show_message_read
    @message = Message.find(params[:id])
    @message.mark_as_read! :for => current_vendor
  end

  def show_message_write
    @emails = current_vendor.config_emails
    @message = Message.find(params[:id])
    @message.mark_as_read! :for => current_vendor
  end

  def move_to_trash
    @messages = Message.find(params[:messages_ids])
    @messages.each do |message|
      message.update(trash: true)
    end
    @config_emails = current_vendor.config_emails.first
    @write_messages = @config_emails.messages.where(status: 1, trash: false).count
    @inbox_messages = @config_emails.messages.where(status: 0, trash: false).count
    @trash_messages = @config_emails.messages.where(trash: true).count
    @starred_messages = @config_emails.messages.where(starred: true).count
    @important_messages = @config_emails.messages.where(important: true).count
    render status: 200, :json => {count_inbox: @inbox_messages, count_write: @write_messages, count_trash: @trash_messages, count_starred: @starred_messages, count_important: @important_messages}
  end

  def edit_starred
    @message = Message.find(params[:id])
    if @message.starred
      @message.update(starred: false)
      render status: 200, :json => {}
    else
      @message.update(starred: true)
      render status: 200, :json => {}
    end
  end

  def edit_important
    @message = Message.find(params[:id])
    if @message.important
      @message.update(important: false)
      render status: 200, :json => {}
    else
      @message.update(important: true)
      render status: 200, :json => {}
    end
  end

  def starred
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(starred: true).order("date desc").page(params[:page]).per(20)
    end
  end

  def important
    @emails = current_vendor.config_emails
    if @config_emails.nil?
      flash[:warning] = "Please connect your email address!!!"
      redirect_to new_config_email_path
    else
      @messages = @config_emails.messages.where(important: true).order("date desc").page(params[:page]).per(20)
    end
  end

  def message_reply_to
    message = Message.find(params[:message_id])
    mas = message.subject.split
    if mas[0] == "Re:"
      @message_reply_to = Message.new(subject: message.subject, body: params[:message][:body], from: message.to, to: message.from, config_email_id: @config_emails.id, date: DateTime.now)
    else
      subject = "Re: " + message.subject
      @message_reply_to = Message.new(subject: subject, body: params[:message][:body], from: message.to, to: message.from, config_email_id: @config_emails.id, date: DateTime.now)
    end
    @message_reply_to.write!
    if @message_reply_to.save
      unless params[:message][:file].nil?
        params[:message][:file].each do |a|
          @message_attachment = @message_reply_to.message_attachments.create!(:file => a)
        end
      end
      UserMailer.send_email(@message_reply_to, @config_emails).deliver
      flash[:info] = "Your message was sent!"
      redirect_to write_emails_path
    end
  end

  private


  def do_authorize
    check_access        
  end 

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
      @inbox_messages_unread = @config_emails.messages.where(status: 0, trash: false).unread_by(current_vendor).count
      @config_emails = current_vendor.config_emails.first
      @write_messages = @config_emails.messages.where(status: 1, trash: false).count
      @inbox_messages = @config_emails.messages.where(status: 0, trash: false).count
      @trash_messages = @config_emails.messages.where(trash: true).count
      @starred_messages = @config_emails.messages.where(starred: true).count
      @important_messages = @config_emails.messages.where(important: true).count
    end
  end

end