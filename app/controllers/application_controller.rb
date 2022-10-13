class ApplicationController < ActionController::API
  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user
    return head :unauthorized unless logged_in?
  end
end
