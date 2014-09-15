class OrderStepsController < ApplicationController
	include Wicked::Wizard
	steps :timeplace, :contact, :payment
	def index
		@times = Timing.all
		 logger.debug "New post: #{@times.inspect}"

	end
	def show
		@times = Timing.order("available_from")
		 logger.debug "SHOW {@times.inspect}"

		order_id = session[:tmp_order]
		@order = Order.find(order_id)
		if @order.cleanduration
			@order.price = @order.cleanduration*15
		end
		@user = User.new
		render_wizard
	end

	def update
		@order = Order.find(session[:tmp_order])
		@order.attributes=params.require(:order).permit(:location, :cleantime, :cleandate, :name, :number, :email, :cleaner, :status)
		@order.status = step.to_s
    	@order.status = 'active' if step == steps.last
    	@order.update_attributes(params[:tmp_order])
		render_wizard @order
	end

	private
	def finish_wizard_path
		@order = Order.find(session[:tmp_order])
		booking_confirmation_order_path(@order)
  		# new_user_path
	end
end
