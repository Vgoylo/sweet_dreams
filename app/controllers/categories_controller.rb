class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(catigory_params)
      flash[:success] = 'Success'
      redirect_to categories_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      flash[:success] = 'Success'
      redirect_to categories_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def catigory_params
    params.require(:category).permit(:name)
  end
end
