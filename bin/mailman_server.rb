#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'mailman'

# require File.expand_path(File.dirname(__FILE__) + '/../config/environment')


# Mailman.config.logger = Logger.new("log/mailman.log")  # uncomment this if you can want to create a log file

Mailman.config.poll_interval = 3 # change this number as per your needs. Default is 60 seconds
Mailman.config.pop3 = {
    server: 'pop.yandex.ua', port: 995, ssl: true,
    username: "serg-koreckij",
    # username: "sergei.koretskiy@gmail.com",
    password: "******"
}

Mailman::Application.run do
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