class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:success] = "Successfully registered!"
			redirect_to articles_path
		else
			flash.now[:danger] = "Miss something?"
			# redirect_to register_path
			render 'new'
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :mail, :password)
		end
end