class VendorForm < ActiveRecord::Base

  has_many :category_forms, :through =>  :vendor_form_category_forms
  has_many :vendor_form_category_forms, dependent: :destroy

  has_many :channel_forms, :through =>  :vendor_form_channel_forms
  has_many :vendor_form_channel_forms, dependent: :destroy

  has_many :option_forms, :through =>  :vendor_form_option_forms
  has_many :vendor_form_option_forms, dependent: :destroy

  # has_many :information_trades, :dependent => :destroy

  validates :business_name, :greeting, :first_name, :last_name, :email, :phone_number, :address,
            :city, :state, :zipcode, :country, :web_site_url_my, presence:  true
  validates :phone_number, :numericality => {:only_integer => true}

  mount_uploader :image, FileUploader

end
