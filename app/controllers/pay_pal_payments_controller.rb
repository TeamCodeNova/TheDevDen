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
              price: item.product.product_price.to_f.round(2).to_s, # Ensure two decimal places
              currency: "CAD",
              quantity: item.quantity
            }
          end
        },
        amount: {
          total: total_amount.to_s, # Use the calculated total amount
          currency: "CAD"
        },
        description: "Order from Your Store"
      }]
    })

    if payment.create
      redirect_url = payment.links.find { |v| v.rel == "approval_url" }.href
      Rails.logger.info "Redirecting to PayPal: #{redirect_url}" # Debugging line
      redirect_to redirect_url, allow_other_host: true # Allow redirect to external URL
    else
      Rails.logger.error "PayPal payment creation failed: #{payment.error}" # Debugging line
      flash[:error] = "Error: #{payment.error}"
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
      # Handle unsuccessful payment
      flash[:alert] = "There was an issue with the PayPal payment."
      redirect_to root_path # Or another appropriate path
    end
  end
end
