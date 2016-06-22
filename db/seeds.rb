# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Company Type 

Company.create(title: "Sales Representative/Wholesaler")
Company.create(title: "Antique Dealer")
Company.create(title: "Manufacturer")
Company.create(title: "Designer")
Company.create(title: "Vintage Dealer")
Company.create(title: "Not Applicable")
Company.create(title: "Hand-crafted / Artisinal")


# Category
Category.create(title: "Furniture")
Category.create(title: "Bath")
Category.create(title: "Outdoor")
Category.create(title: "Kitchen")
Category.create(title: "Lighting")
Category.create(title: "Art")
Category.create(title: "Tabletop")
Category.create(title: "Rugs")
Category.create(title: "Decorative Taxtiles")
Category.create(title: "BED")
Category.create(title: "Decorative Accessories")

# Channel 
Channel.create(title: 'Direct to consumer')
Channel.create(title: 'Show room')
Channel.create(title: 'Brick and Mortar retail store')
Channel.create(title: '3rd party ecommerce site')

# Vendor
Vendor.create(email: 'admin@tendemarbor.com', :password => "password", :admin => true)
Vendor.create(email: 'vendor@tendemarbor.com', :password => "password")
Vendor.create(email: 'vendor_admin@tendemarbor.com', :password => "password")
Vendor.create(email: 'vendor_admin2@tendemarbor.com', :password => "password")

# Permission
Permission.create(name: 'Permissions Vendors Index', description: 'Vendors Index', key: 'vendors_index')
Permission.create(name: 'Permissions Email', description: 'Permissions Email', key: 'email_all_action')

# Role
Role.create(name: 'admin')
Role.create(name: 'vendor_admin')
Role.create(name: 'vendor_default')
