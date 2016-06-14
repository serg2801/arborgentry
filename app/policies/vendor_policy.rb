class VendorPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @vendor = modal
  end

  def all_vendor_users?
    @current_vendor.vendor_admin?
  end
end