class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :index]
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      redirect_to :back
    else
      flash[:errors] = ["Couldn't find that user"]
      redirect_to :back
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
