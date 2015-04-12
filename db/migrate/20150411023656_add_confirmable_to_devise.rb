class AddConfirmableToDevise < ActiveRecord::Migration
  def change
    add_column :vendors, :confirmation_token, :string
    add_column :vendors, :confirmed_at, :datetime
    add_column :vendors, :confirmation_sent_at, :datetime
    add_index :vendors, :confirmation_token, unique: true
    
  end
end
