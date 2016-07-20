class CategoryForm < ActiveRecord::Base

  has_many :vendor_form_category_forms, dependent: :destroy
  has_many :vendor_forms, through: :vendor_form_category_forms

end
