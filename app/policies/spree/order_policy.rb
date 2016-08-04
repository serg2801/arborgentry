class Spree::OrderPolicy < ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    @current_vendor.has_role? :admin or check(:spree_order_index) or check(:spree_order_all_action)
  end

end