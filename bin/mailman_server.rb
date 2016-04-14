#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'mailman'
require 'bcrypt'

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')


# Mailman.config.logger = Logger.new("log/mailman.log")  # uncomment this if you can want to create a log file

Mailman.config.poll_interval = 3 # change this number as per your needs. Default is 60 seconds
# Mailman.config.pop3 = {
#     server: 'pop.yandex.ua', port: 995, ssl: true,
#     username: "serg-koreckij",
#     # username: "sergei.koretskiy@gmail.com",
#     password: "******"
# }

# BEGIN {
#   def inbox_config
#     @config_emails = ConfigEmail.all
#   end
# }

Mailman::Application.run do
  @config_emails = ConfigEmail.all
  @config_emails.each do |config_email|
    initialize do
      Mailman.config.pop3 = {
          server: "pop." + "#{config_email.server_email}", port: 995, ssl: true,
          username: config_email.username,
          password: config_email.password_encrypted
      }
    end
  end
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