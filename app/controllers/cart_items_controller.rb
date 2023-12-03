class CartItemsController < ApplicationController
  before_action :require_user

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user = current_user # Change user_id to user

    if @cart_item.save
      # Log the cart item here
      Rails.logger.info("Cart item added: Product ID - #{cart_item_params[:product_id]}, Quantity - #{cart_item_params[:quantity]}")

      redirect_to cart_items_path, notice: 'Product added to cart!'
    else
      flash.now[:alert] = @cart_item.errors.full_messages.to_sentence
      render 'products/show'
    end
  end

  def index
    @cart_items = current_user.cart_items.includes(:product)
  end

  def destroy
    @cart_item = current_user.cart_items.find_by(id: params[:id])

    if @cart_item
      @cart_item.destroy
      redirect_to cart_items_path, notice: 'Product removed from cart.'
    else
      redirect_to cart_items_path, alert: 'Cart item not found.'
    end
  end

  def update
    @cart_item = current_user.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: 'Cart item updated.'
    else
      flash.now[:alert] = @cart_item.errors.full_messages.to_sentence
      redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity, :user_id)
  end
end
