class AddServerNameToConfigEmails < ActiveRecord::Migration
  def change
    add_column :config_emails, :server_name, :string
  end
end
