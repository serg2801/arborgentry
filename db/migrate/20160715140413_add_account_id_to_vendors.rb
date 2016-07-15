class AddAccountIdToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :account_id, :integer
  end
end
