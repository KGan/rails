class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def create
    @user = User.find_by_credentials(*session_params.values)
    if login!(@user)
      redirect_to @user
    else
      flash.now[:errors] = ["Login error"]
      render :new
    end
  end

  def new
    @user = User.new
  end

  def destroy
    logout!
    redirect_to root_url
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end
