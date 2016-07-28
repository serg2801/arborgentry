class TradeFormPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @vendor = modal
  end

  def index?
    @current_vendor.has_role? :admin
  end

  def show?
    @current_vendor.has_role? :admin
  end

end