class DreamsController < ApplicationController
  def index
    @dreams = Dream.where(user_id: current_user.id).or(Dream.where(private: false)).page params[:page]
  end

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(dream_params)
    @dream.user = current_user
    if @dream.save
      flash[:success] = 'Success'
      redirect_to dreams_path(@dream)
    else
      flash[:error] = 'Error'
      render :new
    end
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
    params.require(:dream).permit(:title, :description, :dream_date, :interval, :private, :image, :category_id)
  end
end
