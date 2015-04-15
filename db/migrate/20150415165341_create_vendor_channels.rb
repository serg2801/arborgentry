class CreateVendorChannels < ActiveRecord::Migration
  def change
    create_table :vendor_channels do |t|
      t.integer :vendor_id
      t.integer :channel_id

      t.timestamps
    end
  end
end
