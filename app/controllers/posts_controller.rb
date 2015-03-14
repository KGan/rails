class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @heirarchy = @post.posted_subs
    @children = @post.comments_hash
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      @post.destroy
    else
      flash[:errors] = @post.errors.full_messages
    end
    redirect_to :back
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, posted_sub_ids: []).merge({user_id: current_user.id})
    end
end
