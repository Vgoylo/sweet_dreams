class TagsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @tag = Tag.all.page(params[:page]).order("#{sort_column} #{sort_direction}").page params[:page]
  end

  def new
    @tag = Tag.new
  end

  def create
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
    @tag = Tag.find(params[:id])
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
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
    sortable_columns.include?(params[:column]) ? params[:column] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
