# frozen_string_literal: true

class DreamsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    authorize Dream
    @dreams =
      if current_user.nil?
        Dream.where(private: false)
      elsif params[:private]
        Dream.by_user(current_user.id).where(private: params[:private])
      elsif params[:user_id]
        Dream.by_user(params[:user_id])
      else
        Dream.by_user(current_user.id).or(Dream.where(private: false))
      end.order("#{sort_column} #{sort_direction}")

    if params[:search]
      search = params[:search]
      @dreams = @dreams.where('title like ? or description like ?', "%#{search}%", "%#{search}%")
    end

    @dreams = @dreams.page params[:page]
  end

  def new
    authorize Dream
    @dream = Dream.new
  end

  def create
    authorize Dream
    @dream = Dream.new(dream_params)
    @dream.user = current_user
    @dream.tag_ids = params[:post][:tag_ids]
    SendMessageNewDreamSidekiqJob.set(wait: 1.minutes).perform_at(1.minutes, @dream.user.name )
    if @dream.save
      flash[:success] = 'Success'
      redirect_to user_path(current_user)
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def show
    authorize Dream
    @dream = Dream.find(params[:id])
    @comment = Comment.new(dream: @dream, user_id: current_user.id)
    @dream_comments = @dream.comments.order(created_at: :desc)
    @reply = Reply.new(comment: @comment, user_id: current_user.id)
    @comment_replies = Reply.all
  end

  def edit
    @dream = Dream.find(params[:id])
    authorize @dream
  end

  def update
    @dream = Dream.find(params[:id])
    authorize @dream
    @dream.user = current_user
    @dream.tag_ids = params[:post][:tag_ids]
    if @dream.update(dream_params)
      flash[:success] = 'Success'
      redirect_to user_path(current_user)
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @dream = Dream.find(params[:id])
    authorize @dream

    if @dream.destroy!
      flash[:success] = 'Success'
      redirect_to user_path(current_user)
    else
      flash[:error] = 'Error'
    end
  end

  private

  def dream_params
    params.require(:dream).permit(:title, :description, :dream_date, :interval, :private, :image, :category_id,
                                  :search, tag_ids: [])
  end

  def sortable_columns
    %w[tilte description private].freeze
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
