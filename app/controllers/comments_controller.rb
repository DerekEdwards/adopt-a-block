class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comments_params)

    respond_to do |format|
      format.html { redirect_to neighborhood_url(@comment.cleaning.block.neighborhood) }
      #format.json { render :show, status: :ok, location: @comment.commentable }
    end
  end

  def delete
    comment = Comment.find(params[:id].to_i)
    unless current_user == comment.user 
      render json: {result: false}
      return
    end
    comment.delete
    render json: {result: true}
  end

  private

  def comments_params
    params.require(:comment).permit(:user_id, :cleaning_id, :message)
  end

end

