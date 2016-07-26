class AddPasDecryptToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :pas_decrypt, :string
  end
end
