  class Admin::UsersController < ApplicationController
    # before_action :authenticate_user!
    helper_method :sort_column, :sort_direction

    def index
      authorize User
      @users = User.where.not("role = 1 OR id = #{current_user.id}").page(params[:page]).order("#{sort_column} #{sort_direction}")

      if params[:search]
        search = params[:search]
        @users = @users.where('name like ? or email like ?', "%#{search}%", "%#{search}%")
      end

      @users = @users.page params[:page]
    end

    def update_block_status
      authorize User
      @user = User.find(params[:id])
      @user.blocked = !@user.blocked
      @user.save!
      RandomJob.perform_later(@user.email)
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(:search, :name)
    end

    def sortable_columns
      %w[name].freeze
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  end
