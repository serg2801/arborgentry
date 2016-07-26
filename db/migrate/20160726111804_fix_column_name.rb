class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :vendor_forms, :user_id, :vendor_id
  end
end
