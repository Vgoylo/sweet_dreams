class DreamsController < ApplicationController
  def index
    @dreams = Dream.where(user_id: current_user.id).or(Dream.where(private: false))
  end

  def show
    @dream = Dream.find(params[:id])
  end

  def edit
    @dream = Dream.find(params[:id])
  end

  def update
    @dream = Dream.find(params[:id])
    if @dream.update(dream_params)
      flash[:success] = 'Success'
      redirect_to dreams_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @dream = Dream.find(params[:id])

    if @dream.destroy
      flash[:success] = 'Success'
      redirect_to dreams_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def dream_params
    params.require(:dream).permit(:title, :description, :dream_date, :interval, :private, :image)
  end
end
