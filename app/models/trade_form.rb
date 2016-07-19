class TradeForm < ActiveRecord::Base

  validates :business_name, :greeting, :first_name, :last_name, :email, :phone_number, :address,
            :city, :state, :zipcode, :country, :web_site_url, presence:  true


  validates :phone_number, :numericality => { :only_integer => true }

  mount_uploader :image, FileUploader

end
