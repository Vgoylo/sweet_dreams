# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    user.id == record.id
  end

  def show?
    !user.blocked
  end

  def index?
    !user.blocked
  end

  def destroy?
    user.admin?
  end

  def update_block_status?
    user.admin?
  end

  def update?
    edit?
  end
end
