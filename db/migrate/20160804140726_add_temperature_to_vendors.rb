class AddTemperatureToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :temperature, :integer, default: 0
  end
end
