class SessionsController < ApplicationController
	def new
	end

	def create
	user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token  
			end
			if session[:tmp_order].blank?
				redirect_to user_path(user.id), notice: "Logged in!"
			else
				@order = Order.find(session[:tmp_order])
				@order.update_attribute(:user_id, user.id)
				session[:tmp_order] = nil
				redirect_to user_path(user.id)
			end
		else
			flash.now.alert = "Email or password is invalid."
		end
	end

	def destroy
		cookies.delete(:auth_token)
		redirect_to root_url, notice: "Logged out!"
	end
end
