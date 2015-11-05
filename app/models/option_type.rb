class OptionType < ActiveRecord::Base
	belongs_to :variant
	has_many :option_values, dependent: :destroy
  accepts_nested_attributes_for :option_values, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
  has_many :option_images, through: :option_values
end
