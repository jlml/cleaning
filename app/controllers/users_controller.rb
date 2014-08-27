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
				cookies[:auth_token] = @user.auth_token  
			else
				@order = Order.find(session[:tmp_order])
				@order.update_attribute(:user_id, @user.id)
				@user.update_attribute(:name, @order.name)
				@user.update_attribute(:address, @order.location)
				@user.update_attribute(:email, @order.email)
				session[:tmp_order]= nil
				cookies[:auth_token] = @user.auth_token 
				redirect_to booking_confirmation_order_path(@order)
			end
		else
			render "new"
		end
	end

	def show
		@user = User.find_by_auth_token(cookies[:auth_token])
	end

	def profile
		@user = User.find_by_auth_token(cookies[:auth_token])
	end

	def edit
		@user = User.find_by_auth_token(cookies[:auth_token])
	end

	def update
		@user = User.find_by_auth_token(cookies[:auth_token])
		if @user.update_attributes(user_params)
			redirect_to action: 'profile'
		else
			render 'edit'
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :number, :address, :password, :password_confirmation)
	end
end
