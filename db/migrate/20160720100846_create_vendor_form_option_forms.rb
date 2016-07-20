class CreateVendorFormOptionForms < ActiveRecord::Migration
  def change
    create_table :vendor_form_option_forms do |t|

      t.integer :vendor_form_id
      t.integer :option_form_id

      t.timestamps null: false
    end
  end
end
