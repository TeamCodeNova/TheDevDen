# app/controllers/products_controller.rb

class ProductsController < ApplicationController
  before_action :require_user
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
