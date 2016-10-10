# Company Type
[ 'Sales Representative/Wholesaler',
	'Antique Dealer', 'Manufacturer',
	'Designer',
	'Vintage Dealer',
	'Not Applicable',
	'Hand-crafted / Artisinal'
].map do |type|
	Company.create( title: type )
end

# Category
[
	'Furniture',
	'Bath',
	'Outdoor',
	'Kitchen',
	'Lighting',
	'Art',
	'Tabletop',
	'Rugs',
	'Decorative Taxtiles',
	'BED',
	'Decorative Accessories'
].map do |category|
	Category.create(title: category)
end

# Channel
[
	'Direct to consumer',
	'Show room',
	'Brick and Mortar retail store',
	'3rd party ecommerce site'
].map do |channel|
	Channel.create(title: channel)
end

# OptionForm
[
	'Sales Rep. or Wholesale',
	'Antique Dealer',
	'Vintage Dealer',
	'Manufacturer',
	'Hand-crafted/Artisinal',
	'Interior Designer',
	'Other/Not Applicable'
].map do |option_form|
	OptionForm.create(title: option_form)
end

# CategoryForm
[
	'Seating',
	'Kitchen',
	'Lighting',
	'Rugs',
	'Decor',
	'Outdoor',
	'Soft Goods',
	'Case Goods'
].map do |category_form|
	CategoryForm.create(title: category_form)
end

# ChannelForm
[
	'Direct to Consumer',
	'Brick and Mortar Store',
	'Showroom',
	'Flash Sales Website(s)',
	'3rd Party e-Commerce Site(s)',
	'Other'
].map do |channel_form|
	ChannelForm.create(title: channel_form)
end

# Vendor
[
  ['admin@tandemarbor.com', 'password', true],
  ['super_admin@tandemarbor.com', 'password', true],
  ['vendor@tandemarbor.com', 'password', false],
  ['vendor_admin@tandemarbor.com', 'password', false]
].map do |e, p, a|
	Vendor.create(email: e, :password => p, :admin => a)
end

# Roles for vendors
[1, 2].map do |id|
	Vendor.find(id).spree_roles << Spree::Role.find_or_create_by(name: "admin")
	Vendor.find(id).add_role :admin
end

# Permission
[
	['Permissions Show all Vendors',         		'Show all Vendors',						'show_all_vendors'],
	['Permissions Create Vendors',           		'Create Vendors', 						'create_vendors'],
  ['Permissions Destroy Vendors',          		'Destroy Vendors', 						'destroy_vendors'],
  ['Permissions All action  Vendors',      		'All actions Vendors', 				'all_action_vendors'],
  ['Permissions All action Email',         		'Email', 											'all_action_email'],
	['Permissions All actions Spree Orders', 		'All actions Spree Orders', 	'spree_order_all_action'],
	['Permissions Index Spree Orders',       		'Index Spree Orders', 				'spree_order_index'],
	['Permissions All actions Spree Products',  'All actions Spree Products', 'spree_product_all_action'],
	['Permissions Index Products', 							'Index Products', 						'spree_product_index'],
  ['Permissions Update Spree Products', 			'Update Spree Products', 			'spree_product_update'],
	['Permissions Destroy Spree Products', 			'Destroy Spree Products',		  'spree_product_destroy'],
	['Permissions Clone Spree Products', 				'Clone Spree Products',				'spree_product_clone']
].map do |n, d, k|
	Permission.create(name: n, description: d, key: k)
end

# Role
['vendor_admin', 'vendor_default'].map do |role|
	Role.create(name: role)
end

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
