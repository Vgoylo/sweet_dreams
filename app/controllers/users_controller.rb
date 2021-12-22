class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.all.page(params[:page]).order("#{sort_column} #{sort_direction}").page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Success'
      redirect_to users_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:success] = 'Success'
      redirect_to users_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def sortable_columns
    %w[name].freeze
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
