class ServicesController < ApplicationController
	before_filter :authenticate_user!

	def new
		@service = Service.new
		@service.timings.build
	end

	def create
		@service = Service.new(service_parameters)
		if @service.save!
			redirect_to root_url
		else
			render :new
		end
	end

	def show
	end

	private

	def service_parameters
		params.require(:service).permit(:name,:description,:cleaner_id, timings_parameters: [:id, :available_at, :_destroy ] )
	end
end
