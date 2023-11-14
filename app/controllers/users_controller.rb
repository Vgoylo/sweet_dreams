# frozen_string_literal: true

class UsersController < ApplicationController
  include ActiveModel::Serialization
  include Sort
  include UserSearch

  before_action :authenticate_user!
  before_action :sort_column, :sort_direction, only: %i[index]
  before_action :user_find, only: %i[show edit update destroy]

  helper_method :sort_column, :sort_direction

  def index
    authorize User

    @users = UsersListQuery.not_admin(current_user)
    search
    @users = @users.order(id: 'desc').map { |user| Users::IndexPresenter.new(user) }
    @users = paginate_array_page
  end

  def show
    authorize User
    @user = Users::Show.call(@user)

    @dreams = dream_presenter
  end

  def edit
    SendMessageEmailJob.perform_later(@user.name)
    SendMessageSidekiqJob.set(wait: 1.minutes)
                         .perform_at(Time.now + 1.minutes, @user.name)
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      flash[:success] = 'Success'
      # render json: @user, serializer: UserSerializer
      redirect_to user_path(@user)
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def delete
    authorize User

    if @user.destroy
      flash[:success] = 'Success'
      redirect_to users_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def paginate_array_page
    Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end

  def dream_presenter
    @user.dreams.order(id: 'desc').map do |dream|
      Dreams::ShowPresenter.new(dream)
    end
  end

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:search, :name)
  end

  def sortable_columns
    %w[name].freeze
  end
end
