class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :logged_in_user
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  def current_user
    @current_user ||= User.find_session(session[:session_token])
  end

  def logged_in?
    current_user != nil
  end

  def login_user!
    location = location_str(request.location)
    useragent = request.env["HTTP_USER_AGENT"]
    ss = @user.sessions.create(user_agent: useragent, location: location)
    session[:session_token] = ss.session_token
  end

  private
    def logged_in_user
      redirect_to new_session_url unless logged_in?
    end

    def location_str(loc)
      ret_str = ""
      ret_str += loc.city + ", " if loc.city
      ret_str += loc.state + ', ' if loc.state
      ret_str += loc.country if loc.country
      ret_str
    end
end
