class ContactController < ApplicationController
  before_action :set_contact_content, only: [:show, :edit, :update]
  before_action :authenticate_admin!, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @contact_content.update(contact_params)
      redirect_to contact_path, notice: 'Contact page updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_contact_content
    @contact_content = Contact.first_or_initialize
  end

  def content_params
    params.require(:contact).permit(:content)
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
