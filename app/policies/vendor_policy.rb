class VendorPolicy < ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:show_all_vendors) or check(:all_action_vendors)
  end

  def show?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:all_action_vendors)
  end

  def new_vendor?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:all_action_vendors)
  end

  def create_vendor?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:create_vendors) or check(:all_action_vendors)
  end

  def edit?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:all_action_vendors)
  end

  def update?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:all_action_vendors)
  end

  def destroy?
    @current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin or check(:destroy_vendors) or check(:all_action_vendors)
  end

end