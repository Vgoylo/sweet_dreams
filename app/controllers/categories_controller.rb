class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category
      flash[:success] = 'Success'
      redirect_to category_path(@category)
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
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

  def category_params
    params.require(:category).permit(:name)
  end
end
