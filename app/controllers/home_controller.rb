class HomeController < ApplicationController


	def booking_confirmation
		@user = User.find_by_auth_token(cookies[:auth_token])
		@orders = @user.orders
		@order = Order.find(params[:order])
	end
end
