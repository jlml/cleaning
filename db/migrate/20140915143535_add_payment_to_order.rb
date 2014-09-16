class AddPaymentToOrder < ActiveRecord::Migration
  def change

    add_column :orders, :paypal_customer_token, :string
  
  end
end
