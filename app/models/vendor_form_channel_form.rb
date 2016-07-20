class VendorFormChannelForm < ActiveRecord::Base

  belongs_to :vendor_form
  belongs_to :channel_form

end
