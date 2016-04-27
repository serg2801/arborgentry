require 'openssl'
require 'base64'
class ConfigEmail < ActiveRecord::Base

  belongs_to :vendor

  has_many :messages

  before_save { username.downcase! }
  before_save { server_email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :password_encrypted, presence: true
  validates :username, uniqueness: true, presence: true,
            format: { with: VALID_EMAIL_REGEX }


  # def encrypt_password(password)
  #   salt = BCrypt::Engine.generate_salt
  #   encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  # end

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

end