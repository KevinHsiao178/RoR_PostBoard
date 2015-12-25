class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully signed in!"
      redirect_to articles_path
    else
      flash[:danger] = "Forgot your password?"
      # redirect_to login_path
      render 'new'
    end
  end

  def destroy
    flash[:info] = "Good-bye~ #{current_user.name}"
    session[:user_id] = nil

    redirect_to articles_path
  end
end