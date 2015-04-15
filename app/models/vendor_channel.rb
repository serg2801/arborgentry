class VendorChannel < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :channel
end
