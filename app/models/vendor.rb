class Vendor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  require 'net/pop'
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable#, :confirmable
  
  has_many :categories, :through => :vendor_categories
  has_many :vendor_categories

  has_many :channels, :through => :vendor_channels
  has_many :vendor_channels

  has_many :companies, :through =>  :vendor_companies
  has_many :vendor_companies, dependent: :destroy

  has_many :config_emails

  has_attached_file :sample_photo, styles: {thumb: "100x100#", small: "300x300#", medium: "500x500#", large: "800x800#"}
  validates_attachment_content_type :sample_photo, content_type: ['image/jpeg', 'image/png', 'application/pdf']

  after_create :send_admin_mail

  acts_as_reader

  def password_required?
    super if confirmed?
  end

  def receive_emails_pop
    self.config_emails.each do |config_email|
      case (config_email.server_email)
        when 'pop.gmail.com'
          Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
        else
          ""
      end
      Net::POP3.start(config_email.server_email, config_email.port, config_email.username, ConfigEmail.decryption(config_email.password_encrypted)) do |pop|
        if pop.mails.empty?
          puts 'No mails.'
        else
          pop.each_mail do |mail|
            UserMailer.current_vendor_config_email(config_email)
            UserMailer.receive(mail.pop)
            mail.delete
          end
          pop.finish
        end
      end
    end
  end

  def receive_emails_imap
    self.config_emails.each do |config_email|
      imap = Net::IMAP.new(config_email.server_email, config_email.port, true)
      imap.login(config_email.username, ConfigEmail.decryption(config_email.password_encrypted))
      imap.select('INBOX')
      if imap.search(["NOT", "SEEN"]).empty?
        puts 'No mails.'
      else
        imap.search(["NOT", "SEEN"]).each do |message_id|
          msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
          mail = Mail.read_from_string msg
          UserMailer.current_vendor_config_email(config_email)
          UserMailer.receive(mail)
        end
      end
      imap.logout
      imap.disconnect
    end
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def send_admin_mail
    VendorMailer.send_admin_mail(self).deliver
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
