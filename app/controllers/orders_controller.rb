class OrdersController < ApplicationController

	def new
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		@order.status = "First Step"
		if @order.save!
			session[:tmp_order] = @order.id
			redirect_to order_steps_path
		else 
			render :new
		end
	end

	def show
		@order = Order.find(params[:id])
	end

	def index
		@order = Order.all
	end

	def edit
		@order = Order.find(params[:id])
	end

	def update 
		@order = Order.find(params[:id])
		@order.update_attributes(order_params)
		redirect_to booking_confirmation_order_path(@order)
	end

	def booking_confirmation
		@user = User.find_by_auth_token(cookies[:auth_token])
		if @user.present?
			@order = Order.find(params[:id])
		else
			redirect_to new_user_path
		end
	end

	def payment
		@order = Order.find(params[:id])
	end

	def get_available_timings

	end

	private
	
	def order_params
		params.require(:order).permit(:rooms,:bathroom,:cleanduration, :status,:location, :cleantime, :cleandate, :name, :number, :email, :cleaner)
	end
end
