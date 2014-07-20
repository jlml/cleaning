class SessionsController < ApplicationController
  def new
  end

	def create
	user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
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
		session[:user_id] = nil
		redirect_to root_url, notice: "Logged out!"
	end
end
