class CreateOptionImages < ActiveRecord::Migration
  def change
    create_table :option_images do |t|

      t.timestamps
    end
  end
end
