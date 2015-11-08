class Collection < ActiveRecord::Base
  has_many :product_collections, dependent: :destroy
	has_many :products, through: :product_collections
end
