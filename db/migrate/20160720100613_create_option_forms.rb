class CreateOptionForms < ActiveRecord::Migration
  def change
    create_table :option_forms do |t|

      t.string :title

      t.timestamps null: false
    end
  end
end
