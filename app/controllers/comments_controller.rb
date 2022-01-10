# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    authorize Comment
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = 'Success'
      redirect_to dream_path(dream_id)
    else
      flash[:error] = 'Error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @dream = @comment.dream

    if @comment.destroy
      flash[:success] = 'Success'
      redirect_to dream_path(@dream)
    else
      flash[:error] = 'Error'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :dream_id).merge(user: current_user)
  end

  def dream_id
    comment_params[:dream_id]
  end
end
