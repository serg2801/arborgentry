class Account < ActiveRecord::Base
  belongs_to :vendor

  validates :name, presence: true
end
