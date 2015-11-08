class CreateProductCollections < ActiveRecord::Migration
  def change
    create_table :product_collections do |t|
      t.references :product, index: true
      t.references :collection, index: true

      t.timestamps
    end
  end
end
