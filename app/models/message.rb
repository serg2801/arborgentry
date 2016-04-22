class Message < ActiveRecord::Base

  belongs_to :config_email

  enum status: [ :read, :write ]

end
