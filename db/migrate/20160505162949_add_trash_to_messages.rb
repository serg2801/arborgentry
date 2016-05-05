class AddTrashToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :trash, :boolean, :default => false
  end
end
