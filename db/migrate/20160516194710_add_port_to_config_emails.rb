class AddPortToConfigEmails < ActiveRecord::Migration
  def change
    add_column :config_emails, :port, :string
  end
end
