class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])

    if @dreams.update(dream_params)
      flash[:success] = 'Success'
      redirect_to users_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])


    if @dream.destroy
      flash[:success] = 'Success'
      redirect_to users_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def catigory_params
    params.require(:user).permit(:name)
  end
end
