class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :topic
      t.string :first_name
      t.string :last_name
      t.text :message
      t.string :email

      t.timestamps
    end
  end
end
