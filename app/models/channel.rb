class Channel < ActiveRecord::Base
	has_many :vendor_chanels
	has_many :vendors, through: :vendor_channels
end
