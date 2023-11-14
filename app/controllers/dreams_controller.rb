# frozen_string_literal: true

class DreamsController < ApplicationController
  include Sort

  helper_method :sort_column, :sort_direction
  before_action :sort_column, :sort_direction, only: %i[index]
  before_action :dream_find, only: %i[show edit update destroy]

  def index
    authorize Dream
    @dreams =
      if current_user.nil?
        DreamsListQuery.dreams_not_private
      elsif params[:private]
        DreamsListQuery.dreams_private(current_user, params)
      elsif params[:user_id]
        DreamsListQuery.dreams_by_user_id(params)
      else
        DreamsListQuery.dreams_by_user_id_false(current_user)
      end.order("#{sort_column} #{sort_direction}")

      if params[:search]
        search = params[:search]
        @dreams = @dreams.where('title like ? or description like ?', "%#{search}%", "%#{search}%")
      end

    @dreams = paginate_array_page
  end

  def new
    authorize Dream
    @dream = Dream.new
  end

  def create
    authorize Dream
    @dream = Dreams::Create.call(dream_params, current_user, params[:post])

    flash_success
  rescue StandardError
    flash[:error] = 'Error'
    render :new
  end

  def show
    authorize Dream

    @comment = Comment.new(dream: @dream, user_id: current_user.id)
    @dream_comments = @dream.comments.order(created_at: :desc)
    @reply = Reply.new(comment: @comment, user_id: current_user.id)
    @comment_replies = Reply.all
    @dream = Dreams::ShowPresenter.new(@dream)
  end

  def edit
    authorize @dream
  end

  def update
    authorize @dream

    @dream = Dreams::Update.call(params: dream_params, user: current_user,
                                 post_params: params[:post], dream: @dream)
    flash_success
  rescue StandardError
    flash[:error] = 'Error'
    render :edit
  end

  def destroy
    authorize @dream
    DeleteDreamsSidekiqJob.perform_at(1.minutes.from_now, current_user.id,
                                      Time.zone.parse('13-04-2022'), Time.zone.now)

    if @dream.destroy!
      flash_success
    else
      flash[:error] = 'Error'
    end
  end

  private

  def paginate_array_page
    Kaminari.paginate_array(@dreams).page(params[:page]).per(20)
  end

  def dream_find
    @dream = Dream.find(params[:id])
  end

  def dream_params
    params.require(:dream).permit(:title, :description, :dream_date, :interval,
                                  :private, :image, :category_id, :search, tag_ids: [])
  end

  def sortable_columns
    %w[tilte description private].freeze
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'title'
  end

  def flash_success
    flash[:success] = 'Success'
    redirect_to user_path(current_user)
  end
end
