class RepliesController < ApplicationController

  def index
    @replise = Reply.all.page(params[:page])
  end

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.create(raply_params)
    if @reply
      flash[:success] = 'Success'
      redirect_to replise_path
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def show
    @reply = Reply.find(params[:id])
  end

  def edit
    @reply = Reply.find(params[:id])
  end

  def update
    @reply = Reply.find(params[:id])

    if @reply.update(replay_params)
      flash[:success] = 'Success'
      redirect_to replay_path
    else
      flash[:error] = 'Error'
      render :edit
    end
  end

  def destroy
    @reply = Reply.find(params[:id])

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
