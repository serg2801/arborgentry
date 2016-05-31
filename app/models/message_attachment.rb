class MessageAttachment < ActiveRecord::Base

  mount_uploader :file, FileUploader
  belongs_to :message

end
