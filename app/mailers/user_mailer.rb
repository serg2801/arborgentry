class UserMailer < ActionMailer::Base

  def current_vendor_config_email(config_email)
    @@config_email = config_email
  end

  def receive(message)
    id_config_email = @@config_email.id
    if message.multipart?
      email_body_html = message.html_part.decoded
      # email_body_text = message.text_part.decoded
      @message = Message.new(subject: message.subject, body: email_body_html, from: message.from.to_a[0],
                             to: message.to.to_a[0], date: message.date, config_email_id: id_config_email)
      @message.read!
      @message.save
      unless message.attachments.blank?
        message.attachments.each do |attachment|
          file = StringIO.new(attachment.decoded)
          file.class.class_eval { attr_accessor :original_filename, :content_type }
          file.original_filename = attachment.filename
          file.content_type = attachment.mime_type
          attachment = MessageAttachment.new
          attachment.file = file
          attachment.message_id = @message.id
          attachment.save
        end
      end
    else
      email_body_html = message.decoded
      # email_body_text = message.decoded
      # email_body_html = message.html_part
      # email_body_text = message.text_part
      email_attachments = []
      @message = Message.new(subject: message.subject, body: email_body_html, from: message.from.to_a[0],
                             to: message.to.to_a[0], date: message.date, config_email_id: id_config_email)
      @message.read!
      @message.save
    end
  end

  def send_email(message, config_email)
    @message = message
    unless @message.message_attachments.blank?
      @message.message_attachments.each do |attachment|
        attachments["#{attachment.file}"] = File.read("#{Rails.root}/public/#{attachment.file}")
      end
    end
    case (config_email.smtp_server)
      when 'pop.gmail.com'
        delivery_options = {address: config_email.smtp_server,
                            port: 587,
                            domain: config_email.server_email,
                            user_name: config_email.username,
                            password: decryption(config_email.password_encrypted),
                            authentication: 'login',
                            enable_starttls_auto: true}
      else
        delivery_options = {address: config_email.smtp_server,
                            port: 25,
                            # domain: config_email.server_email,
                            user_name: config_email.username,
                            password: decryption(config_email.password_encrypted),
                            # authentication: 'login',
                            authentication: 'plain'}
    end


    mail to: @message.to,
         from: @message.from,
         subject: @message.subject,
         delivery_method_options: delivery_options
  end

  private

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

end
