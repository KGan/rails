class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: [:create, :new]
  before_action :owned_session?, only: [:log_out_remote]
  def create
    @user = User.find_by_credentials(*session_params.values)
    if @user
      login_user!
      redirect_to root_url
    else
      flash[:errors] = "Couldn't find user"
      redirect_to :back
    end
  end

  def new
    render :new
  end

  #log out current user
  def destroy
    sess = current_user.sessions.find_by(session_token: session[:session_token])
    session[:session_token] = nil
    if sess
      sess.destroy
      redirect_to root_url
    else
      redirect_to new_session_url
    end
  end

  def log_out_all
    current_user.sessions.each do |session|
      session.destroy unless session.session_token == session[:session_token]
    end
    redirect_to :back
  end

  def log_out_remote
    sess = current_user.sessions.find(params[:id])
    if sess
      sess.destroy
    else
      flash[:error] = "No session"
    end
    redirect_to :back
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
    def owned_session?
      redirect_to root_url unless current_user.id == Session.find(params[:id]).try(:user).try(:id)
    end
end
