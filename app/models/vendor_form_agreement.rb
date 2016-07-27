class VendorFormAgreement < ActiveRecord::Base
  belongs_to :vendor_form
  mount_uploader :vendor_agreement, FileUploader

  validates :vendor_agreement, presence:  true
end
