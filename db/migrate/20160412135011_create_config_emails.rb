class CreateConfigEmails < ActiveRecord::Migration
  def change
    create_table :config_emails do |t|
      t.string :server_email
      t.string :username
      t.string :password_encrypted
      t.references :vendor, index: true, foreign_key: true
      t.boolean :status, :default => true

      t.timestamps
    end
  end
end
