class VendorFormPolicy < ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    #@current_vendor.has_role? :admin
    true
  end

  def new?
    #@current_vendor.has_role? :admin
    true
  end

  def create?
    #@current_vendor.has_role? :admin
    true
  end

  def show?
    #@current_vendor.has_role? :admin or check_vendor_form
    true
  end

  def edit?
    #@current_vendor.has_role? :admin or check_vendor_form
    true
  end

  def update?
    #@current_vendor.has_role? :admin or check_vendor_form
    true
  end

  def grant_access?
    #@current_vendor.has_role? :admin
    true
  end

  private

  #def check_vendor_form
  #  @modal.vendor_id == @current_vendor.id
  #end

end