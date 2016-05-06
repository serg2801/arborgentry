class UserMailer < ActionMailer::Base

  def current_vendor_config_email(config_email)
    @@config_email = config_email
  end

  def receive(message)
    # binding.pry
    message_id = message.subject[/^update (\d+)$/, 1]
    id_config_email = @@config_email.id
    if message_id.present?
      # part_to_use = message.html_part || message.text_part || message
      Message.update(message_id, body: message.body.decoded)
    else
      body = ""
      message.parts.each do |part|
        next unless part.content_type =~ /^text\/html/
        body << part.decode_body
      end



      # if message.multipart?
      #   email_html = message.html_part.body.decoded  #parsing of html content of the email
      #   email_text = message.text_part.body.decoded  # parsing of text content of the email
      #   email_attachments = []   # an array which can be used to store object records of the attachments..
      #   message.attachments.each do |attachment|
      #     file = StringIO.new(attachment.decoded)
      #     file.class.class_eval { attr_accessor :original_filename, :content_type }
      #     file.original_filename = attachment.filename
      #     file.content_type = attachment.mime_type
      #     attachment = Attachment.new    # an attachment model and all the attachments are saved here...
      #     attachment.attached_file = file
      #     attachment.save
      #     email_attachments << attachment   # adding all attachment objects one by one in the array...
      #   end
      # else
      #   email_html = message.body.decoded    # in this case its a plain email so html body is same as text body..
      #   email_text = message.body.decoded
      #   email_attachments = []   # no attachments :)
      # end

       m = Message.new(subject: message.subject, body: message.body.decoded, from: message.from.to_s,
                      to: message.to.to_s, date: message.date, config_email_id: id_config_email)
      m.read!
      m.save
    end
  end

  def send_email(message, config_email)
    @message = message
    unless @message.message_attachments.nil?
      @message.message_attachments.each do |attachment|
        attachments["#{attachment.file}"] = File.read("#{Rails.root}/public/#{attachment.file}")
      end
    end
    # @url  = message_url(@message)
    delivery_options = { address: "smtp." + "#{config_email.server_email}",
                         port: 587,
                         domain: config_email.server_email,
                         user_name: config_email.username,
                         password: decryption(config_email.password_encrypted),
                         authentication: 'login',
                         enable_starttls_auto: true}
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
