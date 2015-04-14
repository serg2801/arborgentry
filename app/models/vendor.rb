class Vendor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_and_belongs_to_many :companies, :join_table => :vendor_companies
  has_and_belongs_to_many :channels, :join_table => :vendor_channels
  has_and_belongs_to_many :categories, :join_table => :vendor_categories
end
