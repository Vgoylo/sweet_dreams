class CategoriesController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    authorize Category
    @categories = Category.all.page(params[:page]).order("#{sort_column} #{sort_direction}").page params[:page]
  end

  def new
    authorize Category
    @category = Category.new
  end

  def create
    authorize Category
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
    authorize Category
    @category = Category.find(params[:id])
  end

  def edit
    authorize Category
    @category = Category.find(params[:id])
  end

  def update
    authorize Category
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
    authorize Category
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
