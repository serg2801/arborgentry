class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :variants, dependent: :destroy
  has_many :option_types
  accepts_nested_attributes_for :variants, :allow_destroy => true#, :reject_if => lambda { |a| a[:sku].blank? }
end
