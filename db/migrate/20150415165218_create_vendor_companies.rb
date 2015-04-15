class CreateVendorCompanies < ActiveRecord::Migration
  def change
    create_table :vendor_companies do |t|
      t.integer :vendor_id
      t.integer :company_id

      t.timestamps
    end
  end
end
