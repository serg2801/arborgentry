class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :subject
      t.text :body
      t.string :to
      t.string :from

      t.timestamps
    end
  end
end
