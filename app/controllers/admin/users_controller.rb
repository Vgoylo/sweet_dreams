class Admin::UsersController < ApplicationController
  # before_action :authenticate_user!
  include Sort
  include UserSearch

  before_action :sort_column, :sort_direction, only: %i[index]

  helper_method :sort_column, :sort_direction

  def index
    authorize User
    @users = UsersListQuery.admin
    search
    @users = @users.map { |user| Users::IndexPresenter.new(user) }
    @users = paginate_array_page
  end

  def update_block_status
    authorize User

    @user = User.find(params[:id])
    @user.blocked = !@user.blocked
    @user.save!
    RandomJob.perform_later(@user.id, Time.zone.parse('01-04-2022'), Time.zone.parse('03-04-2022'))
    redirect_to admin_users_path
  end

  private

  def paginate_array_page
    Kaminari.paginate_array(@users).page(params[:page]).per(20)
  end

  def user_params
    params.require(:user).permit(:search, :name)
  end

  def sortable_columns
    %w[name].freeze
  end
end
