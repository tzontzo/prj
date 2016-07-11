class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(proj_params)
    if @project.save
      session[:project_id] =@project.id
      redirect_to '/admin'
    else
      redirect_to '/'
    end
  end
  private
  def proj_params
    params.require(:project).permit(:name,:description)
  end
end
