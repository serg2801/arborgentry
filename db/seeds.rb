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


Vendor.create(email: 'admin@tendemarbor.com', :password => "password", :admin => true)
Vendor.create(email: 'vendor@tendemarbor.com', :password => "password")
Vendor.create(email: 'test@test.com', :password => "password")
Vendor.create(email: 'test1@test1.com', :password => "password")


Permission.create(name: 'Permissions Vendors Create Destroy', description: 'Permissions Vendors Create Destroy', key: 'vendors_create_destroy')
Permission.create(name: 'Permissions Vendors Show', description: 'Permissions Vendors Show', key: 'vendors_show')
Permission.create(name: 'Permissions Vendors Update', description: 'Permissions Vendors Update', key: 'vendors_update')
Permission.create(name: 'Permissions Email', description: 'Permissions Email', key: 'email_all_action')