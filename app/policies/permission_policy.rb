class PermissionPolicy < ApplicationPolicy  
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    @current_vendor.has_role? :admin
  end

  def new?
    false
  end

  def save?
    @current_vendor.has_role? :admin
  end

  def create?
    false
  end

  def destroy?
    false
  end

  def update?
    false
  end

end