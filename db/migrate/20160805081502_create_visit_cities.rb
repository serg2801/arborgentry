class CreateVisitCities < ActiveRecord::Migration
  def change
    create_table :visit_cities do |t|

      t.string :country_name
      t.string :city
      t.string :latitude
      t.string :longitude
      t.integer :count_visit, default: 0
      t.integer :radius, default: 0

      t.timestamps null: false
    end
  end
end
