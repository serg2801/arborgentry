class RemoveCreatedByAdminFromRole < ActiveRecord::Migration
  def change
    remove_column :roles, :created_by_admin, :boolean
  end
end
