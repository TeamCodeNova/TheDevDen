class OrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = Order.all.includes(:user, :order_items)
  end


  def new
    @cart_items = current_user.cart_items.includes(:product)
    @order = current_user.orders.build
    flash[:alert] =  @order
    calculate_order_totals(@order, @cart_items)
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      process_cart_items(@order, current_user.cart_items)
      redirect_to initiate_pay_pal_payment_path(order_id: @order)
      flash[:alert] =  @order.id
    else
      @cart_items = current_user.cart_items.includes(:product)
      render :new
    end
  end

  def success
    @order = Order.find(params[:id])

  end

  private

  def order_params
    params.require(:order).permit(:total, :tax, :status)
  end


  def calculate_order_totals(order, cart_items)
    subtotal = cart_items.sum { |item| item.product.product_price * item.quantity }
    tax_rate = 0.05 # Assuming a 5% tax rate; adjust as needed
    order.tax = subtotal * tax_rate
    order.total = subtotal + order.tax
  end

  def process_cart_items(order, cart_items)
    cart_items.each do |cart_item|
      order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity)
      cart_item.destroy
    end
  end
end
