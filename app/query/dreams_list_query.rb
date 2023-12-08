# frozen_string_literal: true

class DreamsListQuery

  def self.dreams_not_private
    Dream.where(private: false)
  end

  def self.dreams_private(current_user, params)
    Dream.select('*').from("(#{self.query(params)}) as dreams")
  end

  def self.dreams_by_user_id(params)
    Dream.by_user(params[:user_id])
  end

  def self.dreams_by_user_id_false(current_user)
    Dream.by_user(current_user.id).or(Dream.where(private: false))
  end

  private

  def self.query(params)
    <<-SQL
      SELECT * FROM dreams
      left JOIN users
      on users.id = dreams.user_id
      WHERE dreams.private in (#{params[:private]})
    SQL
  end
end
