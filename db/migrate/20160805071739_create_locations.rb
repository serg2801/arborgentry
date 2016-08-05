class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.string :ip
      t.string :country_name
      t.string :country_code
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :zipcode
      t.string :time_zone
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
