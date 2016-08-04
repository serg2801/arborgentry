class VendorOnboardingFormPolicy < ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
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
    @modal.vendor_id == @current_vendor.id
  end

end