class UserMailer < ActionMailer::Base

  def receive(message)
    message_id = message.subject[/^update (\d+)$/, 1]
    config_email = ConfigEmail.find_by(username: message.to)
    id_config_email = config_email.id
    if message_id.present?
      # part_to_use = message.html_part || message.text_part || message
      Message.update(message_id, body: message.body.decoded)
    else
      body = ""
      message.parts.each do |part|
        next unless part.content_type =~ /^text\/html/
        body << part.decode_body
      end

       m = Message.new(subject: message.subject, body: message.body.decoded, from: message.from.to_s,
                      to: message.to.to_s, date: message.date, config_email_id: id_config_email)
      m.read!
      m.save
    end
  end

  def send_email(message, config_email)
    @message = message
    binding.pry
    @url  = message_url(@message)
    delivery_options = { address: "smtp." + "#{config_email.server_email}",
                         port: 587,
                         domain: config_email.server_email,
                         user_name: config_email.username,
                         password: decryption(config_email.password_encrypted),
                         authentication: 'login',
                         enable_starttls_auto: true}
    mail to: @message.to,
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
