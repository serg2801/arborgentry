class Company < ActiveRecord::Base
	has_many :vendor_companies
	has_many :vendors, through: :vendor_companies
end
