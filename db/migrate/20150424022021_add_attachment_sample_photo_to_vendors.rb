class AddAttachmentSamplePhotoToVendors < ActiveRecord::Migration
  def self.up
    change_table :vendors do |t|
      t.attachment :sample_photo
    end
  end

  def self.down
    remove_attachment :vendors, :sample_photo
  end
end
