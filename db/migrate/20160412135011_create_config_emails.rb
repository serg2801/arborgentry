class CreateConfigEmails < ActiveRecord::Migration
  def change
    create_table :config_emails do |t|
      t.string :server_email
      t.string :username
      t.string :password_encrypted

      t.timestamps
    end
  end
end
