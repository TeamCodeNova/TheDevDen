# app/controllers/admin_sessions_controller.rb
class AdminSessionsController < ApplicationController
  def new
    @admin_session = AdminSessionForm.new
  end

  def create
    @admin_session = AdminSessionForm.new(admin_session_params)

    if @admin_session.valid?
      if admin_authenticated?(@admin_session.email, @admin_session.password)
        session[:admin_id] = User.find_by(email: @admin_session.email).id # Set the admin_id session
        redirect_to admin_products_path # Redirect to the admin dashboard if authentication is successful
      else

        flash[:alert] = 'Invalid email or password.'
        render :new # Render the login form with the error message
      end
    else
      render :new # Render the login form if there are validation errors
    end
  end

  private

  def admin_session_params
    params.require(:admin_session_form).permit(:email, :password)
  end

  # Replace this method with your actual authentication logic
  def admin_authenticated?(email, password)
    # Perform authentication logic, e.g., checking the email and password against the database
    user = User.find_by(email: email)
    if user
      return true
    else
      return false
    end
  end
end
