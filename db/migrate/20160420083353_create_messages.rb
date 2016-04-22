class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.text :subject
      t.text :body
      t.string :to
      t.string :from
      t.integer :status
      t.date :date
      t.references :config_email, index: true, foreign_key: true

      t.timestamps
    end
  end
end
