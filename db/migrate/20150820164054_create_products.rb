class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.text :meta_description
      t.string :meta_keywords
      t.datetime :publish_date
      t.references :vendor, index: true

      t.timestamps
    end
  end
end
