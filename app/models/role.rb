class Role < ActiveRecord::Base
  has_and_belongs_to_many :vendors, :join_table => :vendors_roles

  belongs_to :resource,
             :polymorphic => true
             # :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  has_many :permissions, :through => :role_permissions
  has_many :role_permissions, dependent: :destroy

  validates :name, presence: true


  def has_permission?(key)
    permissions.include? key.to_s
  end

end
