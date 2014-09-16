# PayPal::SDK.load("config/paypal.yml", Rails.env)
# PayPal::SDK.logger = Rails.logger
PayPal::Recurring.configure do |config|
  config.sandbox = false
  config.username = "hongfang.lu_api1.gmail.com"
  config.password = "WQZNH77YFBQE9596"
  config.signature = "A984JzMdznzhGgvB8aOFkFxfEwFbAERDAjxyxuqeeNYn63rU3VsZ8Vmn"
end