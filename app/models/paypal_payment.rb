class PaypalPayment

  def initialize(order)
    @order = order
  end

  def checkout_details
    process :checkout_details
  end

  def checkout_url(options)
    process(:checkout, options).checkout_url
  end


private

  def process(action, options = {})
    options = options.reverse_merge(
      token: @order.paypal_payment_token,
      payer_id: @order.paypal_customer_token,
      description: "SDF",
      amount: "12",
      currency: "SGD"
    )
    response = PayPal::Recurring.new(options).send(action)
    raise response.errors.inspect if response.errors.present?
    response
  end
end