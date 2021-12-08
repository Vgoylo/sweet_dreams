class DreamsController < ApplicationController
  def index
    @dreams = Dream.all
  end

  def show
    @dream = Dream.find(params[:id])
  end

  def edit
    @dream = Dream.find(params[:id])
  end

  def update
    @dream = Dream.find(params[:id])


    if @dreams.update(dream_params)
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

  def catigory_params
    params.require(:dream).permit(:name)
  end
end
