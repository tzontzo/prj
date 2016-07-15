class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end
  def show
    @current_project = Project.find(params[:project_id])

  end
  def create
    @project = Project.new(project_params)
    if @project.save
      session[:project_id] =@project.id
      redirect_to '/admin'
    else
      redirect_to '/'
    end
  end
  def update
    @project = Project.where(params[:project_id])

  end
  def save
    @project = Project.find(params[:project_id])
    @user =  User.find(params[:user])
    if params[:show] == 'true'
      @project.users << @user
    else
      @project.users.delete(@user)
    @project.save!
      render :nothing => true
    end
  end
  private
  def project_params
    params.require(:project).permit(:name,:description)
  end
end
