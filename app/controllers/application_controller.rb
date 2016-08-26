class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init_logged_user, :init_page_title

  def init_logged_user
    if session[:user]
      @logged_user = session[:user]
      else
      redirect_to '/login'
    end
  end
  def init_page_title
    @page_title = 'Project Management App'
  end
end
