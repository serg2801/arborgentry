class CreateMessageAttachments < ActiveRecord::Migration
  def change
    create_table :message_attachments do |t|
      t.integer :message_id
      t.string :file

      t.timestamps
    end
  end
end
