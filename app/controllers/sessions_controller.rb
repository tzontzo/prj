class SessionsController < ApplicationController
  skip_before_action :init_logged_user, only: [:new, :create]

  def new
  end
  def create
    @user = User.find_by_email(params[:session][:email])

    if @user  && @user.authenticate(params[:session][:password])
      session[:user] = @user
      session[:id] = @user.id
      redirect_to '/dashboard'
    else
      redirect_to '/login', notice: "invalid credentials"
    end
  end

  def destroy
    session[:id] = nil
    redirect_to '/login'
  end
end
