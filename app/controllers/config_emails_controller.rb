require 'net/pop'
require 'net/imap'

class ConfigEmailsController < ApplicationController

  before_action :get_config_email, only: [:edit, :update, :show]
  before_action :get_config

  def new
    @config_email = ConfigEmail.new
  end

  def edit
  end

  def show
  end

  def create
    config_email = params[:config_email]
    @config_email = ConfigEmail.new(config_email_params.merge(vendor_id: current_vendor.id))
    @config_email.password_encrypted = ConfigEmail.encryption(config_email[:password_encrypted])
    @config_email.smtp_server = ConfigEmail.parse_out_server(config_email[:server_email])
    if @config_email.save
      flash[:info] = 'Config email has been add!.'
      redirect_to config_email_path(@config_email)
    else
      flash[:warning] = "Error! Please fill out all forms!"
      render 'new'
    end
  end

  def update
    config_email = params[:config_email]
    @config_email.update(config_email_params.merge(vendor_id: current_vendor.id))
    @config_email.password_encrypted = ConfigEmail.encryption(config_email[:password_encrypted])
    @config_email.smtp_server = ConfigEmail.parse_out_server(config_email[:server_email])
    if @config_email.save
      flash[:info] = 'Config email has been successfully updated!'
      redirect_to config_email_path
    else
      flash[:warning] = "Error!"
      render 'edit'
    end
  end

  def decryption_password
    begin
      password = @config_emails.password_encrypted
      cipher = OpenSSL::Cipher.new('AES-128-ECB')
      cipher.decrypt
      cipher.key = ENV["key_encrypt_decrypt"]
      tempkey = Base64.decode64(password)
      crypt = cipher.update(tempkey)
      crypt << cipher.final
      render status: 200, json: crypt.to_json
    rescue Exception => exc
      puts ("Message for the decryption log file for message #{password} = #{exc.message}")
    end
  end

  def test_connection
    begin
      config_email = @config_emails
      case (config_email.server_email)
        when 'pop.gmail.com'
          Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
        else
          ""
      end
      if config_email.server_name == "POP"
        Net::POP3.start(config_email.server_email, config_email.port, config_email.username, ConfigEmail.decryption(config_email.password_encrypted)) do |pop|
          if pop.started?
            pop.finish
            puts 'OK!'
            render status: 200, :json => {message: 'Success!', error_js: false}
          end
        end
      else
        imap = Net::IMAP.new(config_email.server_email, config_email.port, true)
        imap_login = imap.login(config_email.username, ConfigEmail.decryption(config_email.password_encrypted))
        if imap_login[:name] == 'OK'
          render status: 200, :json => {message: 'Success!', error_js: false}
        end
        imap.logout
        imap.disconnect
      end
    rescue Exception => e
      puts ("#{e.message}")
      render status: 200, :json => {message: e.message, error_js: true}
    end
  end

  private

  def config_email_params
    params.require(:config_email).permit(:server_email, :username, :password_encrypted, :vendor_id, :status, :port, :smtp_server, :server_name)
  end

  #Before filters

  def get_config_email
    @config_email = ConfigEmail.find(params[:id])
  end

  def get_config
    @config_emails = current_vendor.config_emails.first
  end

end
