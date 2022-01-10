# frozen_string_literal: true

class ReplyPolicy < ApplicationPolicy
  def create?
    !user.blocked
  end

  def destroy?
    !user.blocked && user.id == record.user.id
  end
end
