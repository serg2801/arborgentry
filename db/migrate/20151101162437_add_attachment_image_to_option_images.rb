class AddAttachmentImageToOptionImages < ActiveRecord::Migration
  def self.up
    change_table :option_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :option_images, :image
  end
end
