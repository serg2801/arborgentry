require 'openssl'
require 'base64'
class ConfigEmail < ActiveRecord::Base

  belongs_to :vendor
  has_many :messages

  before_save { username.downcase! }
  before_save { server_email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :password_encrypted, :port, :server_email, presence: true
  validates :username, uniqueness: true, presence: true,
            format: { with: VALID_EMAIL_REGEX }


  def self.encryption(password)
    begin
      cipher = OpenSSL::Cipher.new('AES-128-ECB')
      cipher.encrypt()
      cipher.key = ENV["key_encrypt_decrypt"]
      crypt = cipher.update(password) + cipher.final()
      crypt_string = (Base64.encode64(crypt))
      return crypt_string
    rescue Exception => exc
      puts ("Message for the encryption log file for message #{password} = #{exc.message}")
    end
  end

  def self.decryption(password)
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

  def self.parse_out_server(server_email)
    out_server = 'smtp.'
    mas = server_email.split('.')
    out_server + mas[1] + '.' + mas[2]
  end

end
