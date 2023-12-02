class OrdersController < ApplicationController
  before_action :require_user

  def new
    @order = Order.new
    @cart_items = current_user.cart_items.includes(:product)
    @order.calculate_total(@cart_items)
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      # Placeholder for PayPal integration
      # Redirect to PayPal payment page
      flash[:notice] = "Order placed successfully. Redirecting to PayPal..."
      redirect_to root_path # Change this to PayPal's URL
    else
      render :new
    end
  end

  private

  def order_params
    # Add required params here
  end
end
