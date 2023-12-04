class CustcategoriesController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
    @products = Product.all
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products

    else
      @products = []
    end
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def products
    # Render the products associated with a specific category
    @category = Category.find(params[:id])
    @products = @category.products
    render partial: 'products_table', locals: { products: @products }
  end
end
