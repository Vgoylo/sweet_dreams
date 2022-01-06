class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { rederect_to dream_url(dream_id), notice: 'Comment was successfully created.' }
      else
        format.html { rederect_to dream_url(dream_id), alert: "Cant save comment: #{@comment.errors.full_messages.join(', ')} "}
      end
    end
  end


  def destroy
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.destroy
        format.html { rederect_to dream_url(dream_id), notice: 'Comment was successfully created.' }
      else
        format.html { rederect_to dream_url(dream_id), alert: "Cant save comment: #{@comment.errors.full_messages.join(', ')} "}
      end
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
