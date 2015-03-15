class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user
  before_action :require_login
  Rails.application.routes.default_url_options[:host] = "localhost:3000"

  def login!(user)
    return false unless user
    session[:session_token] = user.reset_session_token!
    true
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  private
    def require_login
      if !logged_in?
        redirect_to new_session_url
      end
    end
end
