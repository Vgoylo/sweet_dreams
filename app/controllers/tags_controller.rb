# frozen_string_literal: true

class TagsController < ApplicationController
  include Sort

  before_action :sort_column, :sort_direction, only: %i[index]
  before_action :tag_find, only: %i[show edit update destroy]

  helper_method :sort_column, :sort_direction

  def index
    authorize Tag
    @tags = TagsListQuery.all_tags
    @tags = paginate_array_page
  end

  def new
    authorize Tag
    @tag = Tag.new
  end

  def create
    authorize Tag
    @tag = Tag.create(tag_params)
    if @tag
      flash[:success] = 'Success'
      redirect_to tags_path
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def show
    authorize Tag
  end

  def edit
    authorize Tag
  end

  def update
    authorize Tag

    if @tag.update(tag_params)
      flash[:success] = 'Success'
      redirect_to tag_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    authorize Tag

    if @tag.destroy
      flash[:success] = 'Success'
      redirect_to tags_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def paginate_array_page
    Kaminari.paginate_array(@tags).page(params[:page]).per(5)
  end

  def tag_find
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def sortable_columns
    %w[name].freeze
  end
end
