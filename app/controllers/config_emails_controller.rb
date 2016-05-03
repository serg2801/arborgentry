require 'net/pop'

class ConfigEmailsController < ApplicationController

  before_action :get_config_email, only: [:edit, :update, :show]
  before_action :get_config

  def new
    @config_email = ConfigEmail.new
  end

  def edit
  end

  def show
    # @config_emails = current_vendor.config_emails.first
  end

  def create
    config_email = params[:config_email]
    email = config_email[:username]
    email_mas = email.split('@')
    server_email = email_mas[1]
    @config_email = ConfigEmail.new(config_email_params.merge(vendor_id: current_vendor.id, server_email: server_email))
    @config_email.password_encrypted = ConfigEmail.encryption(config_email[:password_encrypted])
    if @config_email.save
      redirect_to inbox_path
      flash[:info] = 'Config email has been add!.'
    else
      render 'new'
      flash[:warning] = "Error! Please fill out all forms!"
    end
  end

  def update
    config_email = params[:config_email]
    email = config_email[:username]
    email_mas = email.split('@')
    server_email = email_mas[1]
    @config_email.update(config_email_params.merge(vendor_id: current_vendor.id, server_email: server_email))
    @config_email.password_encrypted = ConfigEmail.encryption(config_email[:password_encrypted])
    if @config_email.save
      redirect_to config_email_path
      flash[:info] = 'Config email has been successfully edited!'
    else
      render 'edit'
      flash[:warning] = "Error!"
    end
  end

  def decryption_password
    begin
      password = @config_emails.password_encrypted
      cipher = OpenSSL::Cipher.new('AES-128-ECB')
      cipher.decrypt()
      cipher.key = ENV["key_encrypt_decrypt"]
      tempkey = Base64.decode64(password)
      crypt = cipher.update(tempkey)
      crypt << cipher.final()
      # return crypt
      render status: 200, json: crypt.to_json
    rescue Exception => exc
      puts ("Message for the decryption log file for message #{password} = #{exc.message}")
    end
  end

  def test_connection
    begin
      config_email = @config_emails
      Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
      Net::POP3.start('pop.' + "#{config_email.server_email}", 995, config_email.username, ConfigEmail.decryption(config_email.password_encrypted)) do |pop|
        if pop.started?
          pop.finish
          puts 'OK!'
          render status: 200, :json => { message: 'Success!' }
        end
      end
    rescue Exception => e
      puts ("#{e.message}")
      render status: 500, :json => { message: e.message }
    end
  end

  private

  def config_email_params
    params.require(:config_email).permit(:server_email, :username, :password_encrypted, :vendor_id, :status)
  end

  #Before filters

  def get_config_email
    @config_email = ConfigEmail.find(params[:id])
  end

  def get_config
    @config_emails = current_vendor.config_emails.first
  end

end
