class VendorPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @vendor = modal
  end

  def index?
    @current_vendor.has_role? :vendor_admin
    # @current_vendor.roles.first.has_permission?(:vendors_index)
  end

  def show?
  end

  def new_vendor?
    @current_vendor.has_role? :vendor_admin
  end

  def create_vendor?
    @current_vendor.has_role? :vendor_admin
  end

  def edit?
    @current_vendor.has_role? :vendor_admin
  end

  # def update?
  #   @current_vendor.admin? # || @current_vendor.admin?
  # end

  def destroy?
    @current_vendor.has_role? :vendor_admin
  end
end