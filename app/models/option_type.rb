class OptionType < ActiveRecord::Base
	belongs_to :variant
	has_many :option_values
  accepts_nested_attributes_for :option_values, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
end
