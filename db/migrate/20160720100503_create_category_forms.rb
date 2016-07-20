class CreateCategoryForms < ActiveRecord::Migration
  def change
    create_table :category_forms do |t|

      t.string :title

      t.timestamps null: false
    end
  end
end
