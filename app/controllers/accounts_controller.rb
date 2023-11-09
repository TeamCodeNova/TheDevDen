class AccountsController < ApplicationController
  before_action :require_user
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def show
    @user = current_user
    # Assuming @user is the current user's data
  end
end
