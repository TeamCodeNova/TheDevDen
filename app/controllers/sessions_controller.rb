class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session # Protects from session fixation attacks
      session[:user_id] = user.id
      session[:admin_id] = user.admin? ? user.id : nil # Set admin session variable
      remember(user) # This method will be implemented to remember the user
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    forget(current_user) if logged_in? # This method will be implemented to forget the user
    reset_session
    redirect_to login_path, notice: 'Logged out successfully.'
  end

  private

  # Remembers a user in a persistent session by setting a secure cookie.
  def remember(user)
    user.remember # This method will be added in the User model
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget # This method will be added in the User model
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Checks if a user is logged in.
  def logged_in?
    !current_user.nil?
  end

  # Retrieves the current user from the session or cookies.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
end
