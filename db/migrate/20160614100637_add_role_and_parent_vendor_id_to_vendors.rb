class AddRoleAndParentVendorIdToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :role, :integer
    add_column :vendors, :parent_vendor_id, :integer
  end
end
