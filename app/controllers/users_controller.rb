class UsersController < ApplicationController
  def index

  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] =@user.id
          redirect_to '/admin'
    else
      flash.now.alert = "Email or password is invalid."
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to '/admin'
    else
      render  'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/admin'

  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:role,:password)
  end


end
