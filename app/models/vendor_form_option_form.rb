class VendorFormOptionForm < ActiveRecord::Base

  belongs_to :vendor_form
  belongs_to :option_form

end
