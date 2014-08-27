class HomeController < ApplicationController


	def booking_confirmation
		@user = User.find_by_auth_token(cookies[:auth_token])
		if @user.present?
			@order = Order.find(params[:order])
		else
			redirect_to new_user_path
		end
	end

	def payment

	end

end