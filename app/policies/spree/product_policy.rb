class Spree::ProductPolicy < ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    @current_vendor.has_role? :admin or check(:spree_product_index) or check(:spree_product_all_action)
  end

  def update?
    @current_vendor.has_role? :admin or check(:spree_product_update) or check(:spree_product_all_action)
  end

  def destroy?
    @current_vendor.has_role? :admin or check(:spree_product_destroy) or check(:spree_product_all_action)
  end

  def clone?
    @current_vendor.has_role? :admin or check(:spree_product_clone) or check(:spree_product_all_action)
  end

end
