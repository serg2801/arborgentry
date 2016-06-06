class AddStarredAndImportantToMessages < ActiveRecord::Migration

  def up
    add_column :messages, :starred, :boolean, default: false
    add_column :messages, :important, :boolean, default: false
  end

  def down
    remove_column :messages, :starred, :boolean
    remove_column :messages, :important, :boolean
  end
end
