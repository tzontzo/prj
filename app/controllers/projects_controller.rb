class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:project_id])
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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if params[:user_ids] == nil
      render 'projects/show'
    else
      @users = User.find(params[:user_ids])
      @project.users << @users
      redirect_to :back
    end
  end

  private

  def project_params
    params.require(:project).permit(:name,:description,{:user_ids => []})
  end

end
