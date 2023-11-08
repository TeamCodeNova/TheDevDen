# app/controllers/admin_sessions_controller.rb
class AdminSessionsController < ApplicationController
  def new
    @admin_session = AdminSessionForm.new
  end

  def create
    @admin_session = AdminSessionForm.new(admin_session_params)

    if @admin_session.valid?
      user = User.find_by(email: @admin_session.email.downcase)
      # Ensure user exists and authenticate the password
      if user && user.authenticate(@admin_session.password)
        # Ensure the user is an admin
        if user.admin?
          session[:admin_id] = user.id # Set the admin_id session
          redirect_to admin_products_path, notice: 'Admin logged in successfully.'
        else
          flash.now[:alert] = 'You do not have admin privileges.'
          render :new
        end
      else
        flash.now[:alert] = 'Invalid email or password.'
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to admin_login_path, notice: 'Admin logged out successfully.'
  end

  private

  def admin_session_params
    params.require(:admin_session_form).permit(:email, :password)
  end
end
