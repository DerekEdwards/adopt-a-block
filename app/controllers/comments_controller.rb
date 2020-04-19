class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comments_params)
    @redirect_path = comments_params[:redirect_path] || neighborhood_url(@comment.cleaning.block.neighborhood) 

    respond_to do |format|
      format.html { redirect_to @redirect_path }
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

  def update 
    @comment = Comment.find(params[:comment][:id].to_i)
    @comment.message = params[:comment][:message]
    @redirect_path = comments_params[:redirect_path] || neighborhood_url(@comment.cleaning.block.neighborhood) 

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @redirect_path}
        #format.json { render :show, status: :ok, location: @comment.commentable }
      else
        format.html { render :edit }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:user_id, :cleaning_id, :message, :redirect_path)
  end

end

