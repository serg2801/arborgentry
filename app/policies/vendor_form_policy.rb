class VendorFormPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @vendor_form = modal
  end

  def index?
    @current_vendor.has_role? :admin
  end

  def show?
    @current_vendor.has_role? :admin or check_vendor_form
  end

  def edit?
    @current_vendor.has_role? :admin or check_vendor_form
  end

  def update?
    @current_vendor.has_role? :admin or check_vendor_form
  end

  def grant_access?
    @current_vendor.has_role? :admin
  end

  private

  def check_vendor_form
    @vendor_form.vendor_id == @current_vendor.id
  end

end