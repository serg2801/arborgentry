class CreateVendorFormAgreements < ActiveRecord::Migration
  def up
    create_table :vendor_form_agreements do |t|
      t.text :vendor_agreement
      t.integer :vendor_form_id
      t.timestamps null: false
    end
  end

  def down
    drop_table :vendor_form_agreements
  end
end
