class RolePolicy < ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end

  def new?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end

  def show?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end

  def create?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end

  def destroy?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end

  def update?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end

  def create_predefined?
    #@current_vendor.has_role? :vendor_admin or @current_vendor.has_role? :admin
    true
  end
  
end