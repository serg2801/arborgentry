class OptionValue < ActiveRecord::Base
  belongs_to :option_type
  has_many :option_images, dependent: :destroy
  accepts_nested_attributes_for :option_images, :allow_destroy => true, :reject_if => lambda { |a| a[:image].blank? }
end
