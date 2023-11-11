# app/controllers/admin/dashboard_controller.rb

module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_admin!
    def index
      # This action will render the admin dashboard view
    end

    private

    def authenticate_admin!
      redirect_to admin_login_path unless current_admin
    end

    def current_admin
      @current_admin ||= User.find_by(id: session[:admin_id])
    end
  end
end
