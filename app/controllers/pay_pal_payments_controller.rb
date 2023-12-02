# app/controllers/paypal_payments_controller.rb
class PayPalPaymentsController < ApplicationController
  before_action :require_user

  def initiate
    @order = Order.find(params[:order_id])

    payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: {
        payment_method: "paypal"
      },
      redirect_urls: {
        return_url: execute_paypal_payment_url(order_id: @order.id),
        cancel_url: root_url
      },
      transactions: [{
        item_list: {
          items: @order.order_items.map do |item|
            {
              name: item.product.product_name,
              sku: item.product.id.to_s,
              price: item.product.product_price.to_s,
              currency: "CAD",
              quantity: item.quantity
            }
          end
        },
        amount: {
          total: @order.total.to_s,
          currency: "CAD"
        },
        description: "Order from Your Store"
      }]
    })

    if payment.create
      redirect_url = payment.links.find { |v| v.rel == "https://sandbox.paypal.com" }.href
      redirect_to redirect_url
    else
      flash[:error] = payment.error
      redirect_to new_order_path
    end
  end

  def execute
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])

    if payment.execute(payer_id: params[:PayerID])
      @order = Order.find(params[:order_id])
      @order.update(status: 'paid')
      flash[:notice] = "Payment completed successfully."
      redirect_to order_success_path(@order)
    else
      flash[:alert] = "Payment could not be completed."
      redirect_to new_order_path
    end
  end
end
