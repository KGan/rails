class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create # fbc(user, pass)
    @user = User.find_by_credentials(*session_params.values)
    if @user
      login_user!(@user)
      redirect_to user_goals_url(current_user)
    else
      flash[:errors] = "Could not authenticate"
      redirect_to :back
    end
  end

  def destroy
    logout! if logged_in?
    redirect_to user_goals_url(current_user)
  end

  private
    def session_params
      params.require(:user).permit(:username, :password)
    end
end
