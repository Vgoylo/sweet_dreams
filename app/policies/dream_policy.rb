class DreamPolicy < ApplicationPolicy
  def index?
    !user.blocked
  end

  def new?
    !user.blocked
  end

  def create?
    new?
  end

  def show?
    new?
  end

  def edit?
    !user.blocked && user.id == record.user.id
  end

  def update?
    edit?
  end

  def destroy?
    user.admin? || edit?
  end
end
