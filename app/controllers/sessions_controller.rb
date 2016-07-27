class SessionsController < ApplicationController
  def new
  end
  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      case @user.role
        when "admin"
          redirect_to '/admin'
        when "programmer"
          redirect_to '/programmer'
        when "team leader"
          redirect_to '/team_leader'
        else
          redirect_to '/login'

      end
    else
      redirect_to '/login', notice: "invalid credentials"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
