class UsersController < ApplicationController

	def new
		if current_user
			@order = Order.find(session[:tmp_order])
			@order.update_attribute(:user_id, current_user.id)
			session[:tmp_order]= nil
			redirect_to user_path(current_user.id)
		else
			@user = User.new
		end
	end

	def create
		@user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
		if @user.save
			if session[:tmp_order].blank?
				redirect_to root_url, notice: "Sign Up successful"
			else
				@order = Order.find(session[:tmp_order])
				@order.update_attribute(:user_id, @user.id)
				session[:tmp_order]= nil
				redirect_to :action => 'show'
			end
		else
			render "new"
		end
	end

	def show
		@user = User.find(session[:user_id])
	end

end
