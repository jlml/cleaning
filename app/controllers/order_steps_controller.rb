class OrderStepsController < ApplicationController
	include Wicked::Wizard
	steps :timeplace, :contact

	def show
		render_wizard
	end
end
