class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to :back
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @children = @comment.post.comments_hash
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment
      @comment.destroy
    end
    redirect_to :back
  end

  def update
  end

  private
    def comment_params
      params.require(:comment).permit(:content,
        :commentable_id, :commentable_type, :post_id).merge({user_id: current_user.id})
    end
end
