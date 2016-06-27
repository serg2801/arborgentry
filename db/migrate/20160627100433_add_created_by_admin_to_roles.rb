class AddCreatedByAdminToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :created_by_admin, :boolean, default: false
  end
end
