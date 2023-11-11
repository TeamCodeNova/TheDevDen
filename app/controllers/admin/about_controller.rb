# app/controllers/admin/about_controller.rb

module Admin
  class AboutController < ApplicationController
    before_action :authenticate_admin!
    def edit
      @about_content = About.first_or_initialize
    end

    def update
      @about_content = About.first_or_initialize
      if @about_content.update(about_params)
        redirect_to admin_edit_about_path, notice: 'About page updated successfully.'
      else
        render :edit
      end
    end

    private

    def about_params
      params.require(:about).permit(:content)
    end

    def authenticate_admin!
      redirect_to admin_login_path unless current_admin
    end

    def current_admin
      @current_admin ||= User.find_by(id: session[:admin_id])
    end
  end
end
