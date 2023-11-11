class AboutController < ApplicationController
  before_action :set_about_content, only: [:show, :edit, :update]
  before_action :authenticate_admin!, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @about_content.update(about_params)
      redirect_to about_path, notice: 'About page updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_about_content
    @about_content = About.first_or_initialize
  end

  def about_params
    params.require(:about).permit(:content)
  end

  def authenticate_admin!
    # Redirect to a login page or show an error unless the user is an admin
    redirect_to admin_login_path unless current_admin
  end

  def current_admin
    # Logic to determine if the current user is an admin
    @current_admin ||= User.find_by(id: session[:admin_id])
  end
end
