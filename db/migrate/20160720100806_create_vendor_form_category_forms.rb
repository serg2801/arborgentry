class CreateVendorFormCategoryForms < ActiveRecord::Migration
  def change
    create_table :vendor_form_category_forms do |t|

      t.integer :vendor_form_id
      t.integer :category_form_id

      t.timestamps null: false
    end
  end
end
