class RepliesController < ApplicationController
  def create
    @replay = Reply.new(reply_params)
    if @replay.save
      flash[:success] = 'Success'
      redirect_to dream_path(@replay.comment.dream)
    else
      flash[:error] = 'Error'
    end
  end

  def destroy
    @replay = Reply.find(params[:id])

    if @replay.destroy
      flash[:success] = 'Success'
      redirect_to dream_path(@replay.comment.dream)
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
