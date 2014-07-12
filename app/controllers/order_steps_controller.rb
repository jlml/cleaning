class OrderStepsController < ApplicationController
	include Wicked::Wizard
	steps :timeplace, :contact, :payment

	def show
		order_id = session[:tmp_order]
		@order = Order.find(order_id)
		if @order.cleanduration
			@order.price = @order.cleanduration*15
		end
				
		render_wizard
	end

	def update
		@order = Order.find(session[:tmp_order])
		@order.attributes=params.require(:order).permit(:location, :cleantime, :cleandate, :name, :number, :email)
		render_wizard @order
	end
end