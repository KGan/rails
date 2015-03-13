class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub
      @sub.destroy
      redirect_to root_url
    else
      flash[:errors] = "not found"
      redirect_to :back
    end
  end

  private
    def sub_params
      params.require(:sub).permit(:title, :description).merge({user_id: current_user.id})
    end
end
