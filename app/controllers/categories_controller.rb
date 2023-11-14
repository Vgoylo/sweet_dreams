# frozen_string_literal: true

class CategoriesController < ApplicationController
  include Sort

  before_action :authenticate_user!
  before_action :sort_column, :sort_direction, only: %i[index]
  before_action :category_find, only: %i[show edit update destroy]

  helper_method :sort_column, :sort_direction

  def index
    authorize Category

    @categories = CategoriesListQuery.all_categories
    @categories = paginate_array_page
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

    rendor json: @category
  end

  def edit
    authorize Category
  end

  def update
    authorize Category

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

    if @category.destroy
      flash[:success] = 'Success'
      redirect_to categories_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def paginate_array_page
    Kaminari.paginate_array(@categories).page(params[:page]).per(10)
  end

  def category_find
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def sortable_columns
    %w[name].freeze
  end
end
