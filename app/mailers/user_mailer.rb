class UserMailer < ActionMailer::Base

  def receive(message)
    message_id = message.subject[/^update (\d+)$/, 1]
    if message_id.present?
      # part_to_use = message.html_part || message.text_part || message
      Message.update(message_id, body: message.body.decoded)
    else
      body = ""
      message.parts.each do |part|
        next unless part.content_type =~ /^text\/html/
        body << part.decode_body
      end
      Message.create! subject: message.subject, body: message.body.decoded, from: message.from.to_s, to: message.to.to_s
    end
  end

end
