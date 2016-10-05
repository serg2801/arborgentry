class CreateAutoPermissions < ActiveRecord::Migration
  def change
    create_table :auto_permissions do |t|
      t.string :controller_name
      t.string :alias
      t.string :action
      t.integer :status

      t.timestamps null: false
    end
  end
end
