class OptionForm < ActiveRecord::Base

  has_many :vendor_form_option_forms, dependent: :destroy
  has_many :vendor_forms, through: :vendor_form_option_forms

end
