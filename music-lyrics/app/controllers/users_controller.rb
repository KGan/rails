class UsersController < ApplicationController
  before_action :already_logged_in, only: [:create, :new]
  before_action :is_user, only: [:edit, :destroy]
  skip_before_action :logged_in_user, [:create, :new]
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    render :new
  end

  def create
    # fail
    @user = User.new(user_params)
    if @user.save
      login_user!
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      redirect_to root_url
    else
      flash[:error] = "no user found"
      redirect_to :back
    end
  end

  def update
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def already_logged_in
      redirect_to root_url if logged_in?
    end

    def is_user
      redirect_to root_url if current_user.id != params[:id]
    end
end
