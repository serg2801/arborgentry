class Message < ActiveRecord::Base

  belongs_to :config_email

  enum status: [ :read, :write ]

  acts_as_readable :on => :created_at

end
