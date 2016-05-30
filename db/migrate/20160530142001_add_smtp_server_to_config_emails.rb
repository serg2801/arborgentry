class AddSmtpServerToConfigEmails < ActiveRecord::Migration
  def change
    add_column :config_emails, :smtp_server, :string
  end
end
