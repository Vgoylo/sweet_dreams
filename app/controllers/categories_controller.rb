class CategoriesController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    @categories = Category.all.page(params[:page]).order("#{sort_column} #{sort_direction}").page params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category
      flash[:success] = 'Success'
      redirect_to categories_path
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
