class CreateVendorFormChannelForms < ActiveRecord::Migration
  def change
    create_table :vendor_form_channel_forms do |t|

      t.integer :vendor_form_id
      t.integer :channel_form_id

      t.timestamps null: false
    end
  end
end
