class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @heirarchy = @post.posted_subs
    @all_comments = @post.all_comments
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

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, posted_sub_ids: []).merge({user_id: current_user.id})
    end
end
