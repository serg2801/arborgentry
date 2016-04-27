require 'net/pop'

class ConfigEmailsController < ApplicationController

  before_action :set_config_email, only: [:edit, :update]

  def new
    @config_email = ConfigEmail.new
  end

  def edit
  end

  def create
    config_email = params[:config_email]
    email = config_email[:username]
    email_mas = email.split('@')
    server_email = email_mas[1]
    @config_email = ConfigEmail.new(config_email_params.merge(vendor_id: current_vendor.id, server_email: server_email))
    @config_email.password_encrypted = ConfigEmail.encryption(config_email[:password_encrypted])
    if @config_email.save
      render 'messages/write_emails'
      flash[:notice] = 'Config email has been add!.'
    else
      render 'new'
      flash[:warning] = "Error! Please fill out all forms!"
    end
  end

  def update
    if @config_email.update(config_email_params)
      redirect_to projects_path #, notice: "Config email has been successfully edited!"
    end

  end

  private

  def config_email_params
    params.require(:config_email).permit(:server_email, :username, :password_encrypted, :vendor_id, :status)
  end

  #Before filters

  def set_config_email
    @config_email = ConfigEmail.find(params[:id])
  end

end
