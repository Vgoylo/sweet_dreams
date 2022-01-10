# frozen_string_literal: true

class TagsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    authorize Tag
    @tag = Tag.all.page(params[:page]).order("#{sort_column} #{sort_direction}").page params[:page]
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
    @tag = Tag.find(params[:id])
  end

  def edit
    authorize Tag
    @tag = Tag.find(params[:id])
  end

  def update
    authorize Tag
    @tag = Tag.find(params[:id])

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
    @tag = Tag.find(params[:id])

    if @tag.destroy
      flash[:success] = 'Success'
      redirect_to tags_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def sortable_columns
    %w[name].freeze
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
