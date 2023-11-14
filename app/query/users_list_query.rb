# frozen_string_literal: true

class UsersListQuery

  def self.not_admin(current_user)
    User.where(id: "#{current_user.id}").or(User.where(role: 0))
  end

  def self.admin
    User.all
  end
end
