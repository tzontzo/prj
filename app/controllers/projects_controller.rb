class ProjectsController < ApplicationController

  def new
    @project = Project.new
    @users = User.all
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
    @project = Project.find(params[:id])
    @user = User.find(params[:id])
    @project.users << User.find(params[:id])
      redirect_to '/admin'

  end

  private
  def project_params
    params.require(:project).permit(:name,:description)
  end

end
