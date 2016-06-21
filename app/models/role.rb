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
  validates :permissions, presence: true


  def has_permission?(key)
    mas_key = []
    permissions.each do |permission|
      mas_key << permission.key
    end
    mas_key.include? key.to_s
  end

end
