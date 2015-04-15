class AddBusinessAddressToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :business_address, :string
  end
end
