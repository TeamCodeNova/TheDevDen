class CustcategoriesController < ApplicationController
    def index
        @categories = Category.all
    
        # Check if a category is selected for filtering
        if params[:category_id].present?
          @category = Category.find(params[:category_id])
          @products = @category.products
        else
          @products = []
        end
    def show
      @category = Category.find(params[:id])
      @products = @category.products
    end
  end
end
  