class VendorCompany < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :company
end
