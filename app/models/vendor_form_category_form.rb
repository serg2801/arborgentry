class VendorFormCategoryForm < ActiveRecord::Base

  belongs_to :vendor_form
  belongs_to :category_form

end
