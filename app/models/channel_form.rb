class ChannelForm < ActiveRecord::Base

  has_many :vendor_form_channel_forms, dependent: :destroy
  has_many :vendor_forms, through: :vendor_form_channel_forms

end
