class MessagesTableChangeColumnType < ActiveRecord::Migration
  def up
    change_column :messages, :date, :datetime, :null => false
  end

  def down
    change_column :messages, :date, :date
  end
end
