class AddSpreeFieldsToCustomUserTable < ActiveRecord::Migration
  def up
    add_column "vendors", :spree_api_key, :string, limit: 48
    add_column "vendors", :ship_address_id, :integer
    add_column "vendors", :bill_address_id, :integer
  end
end
