class Role < ActiveRecord::Base
  has_and_belongs_to_many :vendors, :join_table => :vendors_roles

  belongs_to :resource,
             :polymorphic => true
  # :optional => true

  validates :resource_type,
            :inclusion => {:in => Rolify.resource_types},
            :allow_nil => true

  scopify

  has_many :permissions, :through => :role_permissions
  has_many :role_permissions, dependent: :destroy
  has_many :role_groups, dependent: :destroy

  validates :name, presence: true
  # validates :permissions, presence: true

  belongs_to :vendor_creator, class_name: 'Vendor', foreign_key: :vendor_id

  def has_permission?(key)
    mas_key = []
    permissions.each do |permission|
      mas_key << permission.key
    end
    mas_key.include? key.to_s
  end

  def add_default_role
    vendors = Vendor.with_role self.name
    vendors.each do |vendor|
      vendor.add_role :default_user
    end
  end

  def self.created_by_admin_and_current(current_vendor)
    roles = []
    all.map do |r|
      unless r.vendor_creator.blank?
        roles << r if r.vendor_id == current_vendor.id
        roles << r if r.vendor_creator.has_role? :admin
      end
    end
    roles
  end
end
