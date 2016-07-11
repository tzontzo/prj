class SessionsController < ApplicationController
  def new
  end
  def create
    @user = User.find_by_email(params[:session][:email])
    @rol = @user.role
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      case @rol
        when "admin"
          redirect_to '/admin'
        when "programmer"
          redirect_to '/programmer'
        when "team_leader"
          redirect_to '/tleader'
        else
          redirect_to '/login'

      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
