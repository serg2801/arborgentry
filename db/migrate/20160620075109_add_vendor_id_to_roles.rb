class AddVendorIdToRoles < ActiveRecord::Migration
  def up
    add_column :roles, :vendor_id, :integer
    remove_column :vendors, :role
  end

  def down
    remove_column :roles, :vendor_id
    add_column :vendors, :role, :integer
  end
end
