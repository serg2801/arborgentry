class ApplicationPolicy
  attr_reader :current_vendor, :modal

  def initialize(current_vendor, modal)
    @current_vendor = current_vendor
    @modal = modal
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :current_vendor, :modal

    def initialize(current_vendor, modal)
      @current_vendor = current_vendor
      @modal = modal
    end

    def resolve
      scope
    end
  end

  private

  def check(permission)
    @current_vendor.roles.map { |r| r.has_permission?(permission) }.include? true
  end

end
