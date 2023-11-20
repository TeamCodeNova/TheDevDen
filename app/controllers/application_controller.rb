# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  helper_method :current_admin

  private

  def redirect_back_or_default(default, options = {})
  redirect_to(request.referer.present? ? :back : default, options)
end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def logged_in?
    !!current_user
  end

  def current_admin
    @current_admin ||= User.find_by(id: session[:admin_id])
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to perform that action."
      redirect_to login_path
    end
  end
end
