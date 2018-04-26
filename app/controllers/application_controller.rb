class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  
  def not_current_user
    session[:user_id] == nil
  end

  def logged_in?
    !!current_user  # converting into a bolean
  # else
  #   redirect_to root_path
  end
  
    helper_method :current_user, :not_current_user, :logged_in?
end

