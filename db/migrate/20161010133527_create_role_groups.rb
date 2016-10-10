class CreateRoleGroups < ActiveRecord::Migration
  def change
    create_table :role_groups do |t|
      t.integer :group_id
      t.integer :role_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
