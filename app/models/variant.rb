class Variant < ActiveRecord::Base
	belongs_to :product
	has_many :option_types, dependent: :destroy
  accepts_nested_attributes_for :option_types, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
  has_many :option_images, through: :option_types
end
