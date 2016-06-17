class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|

      t.string :name

      t.timestamps
    end
    add_column :vendors, :role_id, :integer
  end

  def down
    drop_table :roles
    remove_column :vendors, :role_id
  end
end
