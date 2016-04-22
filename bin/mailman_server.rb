#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'mailman'
require 'bcrypt'

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')


# Mailman.config.logger = Logger.new("log/mailman.log")  # uncomment this if you can want to create a log file

Mailman.config.poll_interval = 60 # change this number as per your needs. Default is 60 seconds
# Mailman.config.pop3 = {
#     server: 'pop.yandex.ua', port: 995, ssl: true,
#     username: "serg-koreckij",
#     # username: "sergei.koretskiy@gmail.com",
#     password: "******"
# }

BEGIN {
  def decryption(password)
    begin
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
  end

  def inbox_config
    ConfigEmail.find_by(id: ARGV[0])
  end
}

Mailman::Application.run do
  # @config_emails = ConfigEmail.all
  # @config_emails.each do |config_email|
  initialize do
    Mailman.config.pop3 = {
        server: "pop." + "#{inbox_config.server_email}", port: 995, ssl: true,
        username: inbox_config.username,
        password: decryption(inbox_config.password_encrypted)
    }
  end
  # end
  default do
    begin
      p "Found a new message"
      UserMailer.receive(message)

    rescue Exception => e
      Mailman.logger.error "Exception occurred while receiving message:n#{message}"
      Mailman.logger.error [e, *e.backtrace].join("n")
    end
  end
end