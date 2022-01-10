# frozen_string_literal: true

class RepliesController < ApplicationController
  def create
    authorize Reply
    @reply = Reply.new(reply_params)
    if @reply.save
      flash[:success] = 'Success'
      redirect_to dream_path(@reply.comment.dream)
    else
      flash[:error] = 'Error'
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    authorize @reply

    if @reply.destroy
      flash[:success] = 'Success'
      redirect_to dream_path(@reply.comment.dream)
    else
      flash[:error] = 'Error'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:text, :comment_id).merge(user: current_user)
  end

  def dream_id
    reply_params[:dream_id]
  end
end
