class CleanersController < ApplicationController

	def new
		@cleaner = Cleaner.new
		@cleaner.build_user
	end

	def create
		@cleaner = Cleaner.new(cleaner_parameters)
		if @cleaner.save!
			redirect_to root_url
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private 

	def cleaner_parameters
		params.require(:cleaner).permit(:name, user_attributes: [:id, :username ,:email,:password,:password_confirmation])
	end
end
