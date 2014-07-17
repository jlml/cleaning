class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
		if @user.save
			redirect_to root_url, notice: "Sign Up successful"
		else
			render "new"
		end
	end

end
