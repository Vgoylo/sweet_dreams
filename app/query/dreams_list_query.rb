# frozen_string_literal: true

class DreamsListQuery

  def self.dreams_not_private
    Dream.where(private: false)
  end

  def self.dreams_private(current_user, params)
    Dream.by_user(current_user.id).where(private: params[:private])
  end

  def self.dreams_by_user_id(params)
    Dream.by_user(params[:user_id])
  end

  def self.dreams_by_user_id_false(current_user)
    Dream.by_user(current_user.id).or(Dream.where(private: false))
  end
end
