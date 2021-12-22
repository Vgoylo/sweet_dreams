class RepliesController < ApplicationController

  def index
    @reply = Replies.all.page(params[:page])
  end

  def new
    @reply = Replies.new
  end

  def create
    @reply = Replies.create(raply_params)
    if @reply
      flash[:success] = 'Success'
      redirect_to reply_path(@reply)
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def show
    @reply = Replies.find(params[:id])
  end

  def edit
    @reply = Replies.find(params[:id])
  end

  def update
    @reply = Replies.find(params[:id])

    if @reply.update(replay_params)
      flash[:success] = 'Success'
      redirect_to replay_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @reply = Replies.find(params[:id])

    if @reply.destroy
      flash[:success] = 'Success'
      redirect_to reply_path
    else
      flash[:error] = 'Error'
    end
  end

  private

  def category_params
    params.require(:reply).permit(:name)
  end
end
