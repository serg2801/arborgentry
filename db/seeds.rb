# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Company Type 

Company.create(title: 'Sales Representative/Wholesaler')
Company.create(title: 'Antique Dealer')
Company.create(title: 'Manufacturer')
Company.create(title: 'Designer')
Company.create(title: 'Vintage Dealer')
Company.create(title: 'Not Applicable')
Company.create(title: 'Hand-crafted / Artisinal')


# Category
Category.create(title: 'Furniture')
Category.create(title: 'Bath')
Category.create(title: 'Outdoor')
Category.create(title: 'Kitchen')
Category.create(title: 'Lighting')
Category.create(title: 'Art')
Category.create(title: 'Tabletop')
Category.create(title: 'Rugs')
Category.create(title: 'Decorative Taxtiles')
Category.create(title: 'BED')
Category.create(title: 'Decorative Accessories')

# Channel 
Channel.create(title: 'Direct to consumer')
Channel.create(title: 'Show room')
Channel.create(title: 'Brick and Mortar retail store')
Channel.create(title: '3rd party ecommerce site')


# OptionForm
OptionForm.create(title: 'Sales Rep. or Wholesale')
OptionForm.create(title: 'Antique Dealer')
OptionForm.create(title: 'Vintage Dealer')
OptionForm.create(title: 'Manufacturer')
OptionForm.create(title: 'Hand-crafted/Artisinal')
OptionForm.create(title: 'Interior Designer')
OptionForm.create(title: 'Other/Not Applicable')

# CategoryForm
CategoryForm.create(title: 'Seating')
CategoryForm.create(title: 'Kitchen')
CategoryForm.create(title: 'Lighting')
CategoryForm.create(title: 'Rugs')
CategoryForm.create(title: 'Decor')
CategoryForm.create(title: 'Outdoor')
CategoryForm.create(title: 'Soft Goods')
CategoryForm.create(title: 'Case Goods')

# ChannelForm
ChannelForm.create(title: 'Direct to Consumer')
ChannelForm.create(title: 'Brick and Mortar Store')
ChannelForm.create(title: 'Showroom')
ChannelForm.create(title: 'Flash Sales Website(s)')
ChannelForm.create(title: '3rd Party e-Commerce Site(s)')
ChannelForm.create(title: 'Other')

# Vendor
Vendor.create(email: 'admin@tandemarbor.com', :password => 'password', :admin => true)
Vendor.create(email: 'vendor@tandemarbor.com', :password => 'password')
Vendor.create(email: 'vendor_admin@tandemarbor.com', :password => 'password')
Vendor.create(email: 'vendor_admin2@tandemarbor.com', :password => 'password')

# Permission
Permission.create(name: 'Permissions Show all Vendors',     description: 'Show all Vendors',     key: 'show_all_vendors')
Permission.create(name: 'Permissions Create Vendors',       description: 'Create Vendors',       key: 'create_vendors')
Permission.create(name: 'Permissions Destroy Vendors',      description: 'Destroy Vendors',      key: 'destroy_vendors')
Permission.create(name: 'Permissions All action  Vendors',  description: 'All actions Vendors',  key: 'all_action_vendors')

Permission.create(name: 'Permissions All action Email', description: 'Email', key: 'all_action_email')

Permission.create(name: 'Permissions All action Spree',  description:  'Spree', key: 'all_action_spree')

# Role
Role.create(name: 'admin')
Role.create(name: 'vendor_admin')
Role.create(name: 'vendor_default')



Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
