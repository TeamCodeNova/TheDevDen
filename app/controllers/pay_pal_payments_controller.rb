# app/controllers/paypal_payments_controller.rb
class PayPalPaymentsController < ApplicationController
  before_action :require_user

  def initiate
    @order = Order.find(params[:order_id])

    # Calculate the total item amount
    item_total = @order.order_items.sum { |item| item.product.product_price.to_f * item.quantity }
    # Calculate the total amount for the order
    total_amount = item_total.to_f.round(2) # Ensure two decimal places

    payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: {
        payment_method: "paypal"
      },
      redirect_urls: {
        return_url: execute_pay_pal_payment_url(order_id: @order.id, only_path: false),
        cancel_url: root_url(only_path: false)
      },
      transactions: [{
        item_list: {
          items: @order.order_items.map do |item|
            {
              name: item.product.product_name,
              sku: item.product.id.to_s,
              price: item.product.product_price.to_f.round(2).to_s,
              currency: "CAD",
              quantity: item.quantity
            }
          end
        },
        amount: {
          total: total_amount.to_s,
          currency: "CAD"
        },
        description: "Order from Your Store"
      }]
    })

    if payment.create
      redirect_url = payment.links.find { |v| v.rel == "approval_url" }.href
      redirect_to redirect_url, allow_other_host: true
    else
      flash[:error] = "Error: #{payment.error}"
      redirect_to new_order_path
    end
  end

  def execute
    payment_id = params[:paymentId]
    payer_id = params[:PayerID]

    payment = PayPal::SDK::REST::Payment.find(payment_id)

    if payment.execute(payer_id: payer_id)
      @order = Order.find_by(id: params[:order_id])

      if @order
        # Update the order with the PayPal payment ID
        @order.update(status: 'paid', paypal_payment_id: payment_id)

        flash[:notice] = "Payment completed successfully."
        redirect_to order_success_path(@order)
      else
        flash[:alert] = "Order not found."
        redirect_to root_path
      end
    else
      flash[:alert] = "Payment could not be completed."
      redirect_to new_order_path
    end
  end
end