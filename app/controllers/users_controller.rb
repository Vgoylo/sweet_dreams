# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
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

  def show
    authorize User
    @user = User.find(params[:id])
    SendMessageEmailJob.set(wait: 1.minutes).perform_later(@user.name)
    @dreams = @user.dreams
  end

  def edit
    @user = User.find(params[:id])
    GetsDreamsInTheIntervalSidekiqJob.perform_at(1.minutes, @user.id, Time.zone.parse('13-04-2022'), Time.zone.now)
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      SendMessageSidekiqJob.set(wait: 1.minutes).perform_at(1.minutes, @user.name)
      flash[:success] = 'Success'
      redirect_to user_path(@user)
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize User

    if @user.destroy
      flash[:success] = 'Success'
      redirect_to users_path
    else
      flash[:error] = 'Error'
    end
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
