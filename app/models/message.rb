class Message < ActiveRecord::Base

  belongs_to :config_email

  acts_as_readable :on => :created_at

  mount_uploader :file, FileUploader

  enum status: [ :read, :write ]

end
