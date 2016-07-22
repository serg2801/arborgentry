class ConfigEmailPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @vendor = modal
  end

  def show?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:email_all_action)
  end

  def new?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:email_all_action)
  end

  def create?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:email_all_action)
  end

  def edit?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:email_all_action)
  end

  def update?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:email_all_action)
  end

  def test_connection?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:email_all_action)
  end


  private

  def check(permission)
    @current_vendor.roles.map { |r| r.has_permission?(permission) }.include? true
  end
end