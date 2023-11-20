class ProductsController < ApplicationController
  before_action :require_user

  def index
    @products = Product.all
    @products = @products.where(category_id: params[:category]) if params[:category].present?
    @products = @products.where('product_name LIKE ? OR product_description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword].present?
    apply_filters if params[:filter].present?
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def apply_filters
    case params[:filter]
    when 'on_sale'
      @products = @products.where('product_price < ?', 20)
    when 'new'
      @products = @products.where('created_at >= ?', 3.days.ago)
    when 'recently_updated'
      updated_products = @products.where('updated_at >= ?', 3.days.ago)
      @products = updated_products.where.not('created_at >= ?', 3.days.ago)
    end
  end
end
