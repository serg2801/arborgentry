class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
      t.string :name
      t.references :option_type, index: true

      t.timestamps
    end
  end
end
