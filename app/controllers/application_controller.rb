class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery

  helper_method :current_user
  helper_method :previous_search
  helper_method :previous_sort

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def previous_search
    return session[:previous]
  end

  def previous_sort
    return session[:sort]
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end
end
