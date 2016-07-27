class VendorForm < ActiveRecord::Base

  has_many :category_forms, :through =>  :vendor_form_category_forms
  has_many :vendor_form_category_forms, dependent: :destroy

  has_many :channel_forms, :through =>  :vendor_form_channel_forms
  has_many :vendor_form_channel_forms, dependent: :destroy

  has_many :option_forms, :through =>  :vendor_form_option_forms
  has_many :vendor_form_option_forms, dependent: :destroy

  belongs_to :vendor, :dependent => :destroy

  has_many :vendor_form_agreements, :dependent => :destroy

  validates :business_name, :greeting, :first_name, :last_name, :email, :phone_number, :address,
            :city, :state, :zipcode, :country, :web_site_url_my, presence:  true
  validates :phone_number, :numericality => {:only_integer => true}

  mount_uploader :image, FileUploader


  def self.generate_password
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    password_string = (0...20).map { o[rand(o.length)] }.join
  end

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
