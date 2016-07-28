class VendorOnboardingFormPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @vendor_onboarding = modal
  end

  def index?
    @current_vendor.has_role? :admin
  end

  def show?
    @current_vendor.has_role? :admin or check_vendor_onboarding_form
  end

  def edit?
    @current_vendor.has_role? :admin or check_vendor_onboarding_form
  end

  def update?
    @current_vendor.has_role? :admin or check_vendor_onboarding_form
  end

  def new?
    @current_vendor.has_role? :admin or check_vendor_form
  end

  def create?
    @current_vendor.has_role? :admin or check_vendor_form
  end

  private

  def check_vendor_form
    vendor_form = VendorForm.find_by(vendor_id: @current_vendor.id)
    vendor_form == nil ? false : true
  end

  def check_vendor_onboarding_form
    @vendor_onboarding.vendor_id == @current_vendor.id
  end

end