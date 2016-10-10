class CreateAutoPermissions < ActiveRecord::Migration
  def change
    create_table :auto_permissions do |t|
      t.string :controller_name      
      t.string :action
      t.string :alias
      t.string :description
      t.integer :status

      t.timestamps null: false
    end
  end
end
