class CreateVendorCategories < ActiveRecord::Migration
  def change
    create_table :vendor_categories do |t|
      t.integer :vendor_id
      t.integer :category_id

      t.timestamps
    end
  end
end
