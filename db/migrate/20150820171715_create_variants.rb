class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :sku
      t.string :barcode
      t.float :weight
      t.float :weight_unit
      t.float :price
      t.float :compare_price
      t.boolean :is_master, :default => false

      t.timestamps
    end
  end
end
