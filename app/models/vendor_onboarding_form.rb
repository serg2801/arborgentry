class VendorOnboardingForm < ActiveRecord::Base
  has_many :onboarding_brands
  has_many :onboarding_transportation
  has_many :onboarding_carriers
  has_many :onboarding_product_types

  belongs_to :vendor, :dependent => :destroy

  mount_uploader :w_9_form, FileUploader
  mount_uploader :certificate, FileUploader


  accepts_nested_attributes_for :onboarding_brands, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :onboarding_transportation, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :onboarding_carriers, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :onboarding_product_types, reject_if: :all_blank, allow_destroy: true

  validates :primary_business_email, presence:  true

  def display_name
    # "#{first_name} #{last_name}"
  end
end
