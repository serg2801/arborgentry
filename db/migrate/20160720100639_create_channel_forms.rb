class CreateChannelForms < ActiveRecord::Migration
  def change
    create_table :channel_forms do |t|

      t.string :title

      t.timestamps null: false
    end
  end
end
