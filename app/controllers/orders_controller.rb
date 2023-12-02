# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :require_user

  def new
    @cart_items = current_user.cart_items.includes(:product)
    @order = current_user.orders.build
    @order.calculate_total(@cart_items)
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.calculate_total(current_user.cart_items)

    if @order.save
      current_user.cart_items.each do |cart_item|
        @order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity)
        cart_item.destroy
      end

      redirect_to initiate_paypal_payment_path(order_id: @order.id)
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit()
  end
end
