class Message < ActiveRecord::Base

  belongs_to :config_email
  has_many :message_attachments
  accepts_nested_attributes_for :message_attachments

  acts_as_readable :on => :created_at

  enum status: [ :read, :write ]

end
