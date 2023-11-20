# app/controllers/admin/categories_controller.rb

module Admin
    class CategoriesController < ApplicationController
      before_action :authenticate_admin!
  
      def index
        @categories = Category.all
      end
  
      def new
        @category = Category.new
      end
  
      def new_from_product_form
        @category = Category.new
        render layout: false
      end
  
      def create
        @category = Category.new(category_params)
  
        if @category.save
          flash[:notice] = 'Category was successfully created.'
        else
          flash[:alert] = 'Category creation failed.'
        end
  
        redirect_to admin_categories_path
      end

      def edit
        @category = Category.find(params[:id])
      end
  
      def update
        @category = Category.find(params[:id])
  
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: 'Category was successfully updated.'
        else
          render :edit
        end
      end
  
  
      def destroy
        @category = Category.find(params[:id])
        @category.destroy
        flash[:notice] = 'Category was successfully deleted.'
        redirect_to admin_categories_path
      end
  
      private
  
      def category_params
        params.require(:category).permit(:category_name)
      end
  
      def authenticate_admin!
        redirect_to admin_login_path unless current_admin
      end
  
      def current_admin
        @current_admin ||= User.find_by(id: session[:admin_id])
      end
    end
  end
  