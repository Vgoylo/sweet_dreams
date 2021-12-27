class CommentsController < ApplicationController

  def index
    @comments = Comment.where(dream_id: params[:dream_id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Success'
      redirect_to coments_path(@comment)
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.user = current_user
    @comment.tag_ids = params[:post][:tag_ids]
    if @comment.update(comment_params)
      flash[:success] = 'Success'
      redirect_to comments_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Success'
      redirect_to comments_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :dream_id)
  end
end
