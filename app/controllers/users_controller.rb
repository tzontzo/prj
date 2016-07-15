class UsersController < ApplicationController

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] =@user.id
          redirect_to '/login'
    else
      flash.now.alert = "Email or password is invalid."
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to logout_path, :notice => "Logged out"
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:role,:password)
  end
end
