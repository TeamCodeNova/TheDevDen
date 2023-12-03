class AddPaypalPaymentIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :paypal_payment_id, :string
  end
end
