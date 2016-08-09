class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
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
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end
  def delete_user
    @project = Project.find(params[:id])
    @user  = User.find(params[:user_id])
    @project.users.delete(@user)
    redirect_to :back
  end
  private

  def project_params
    params.require(:project).permit(:name,:description,{:user_ids => []})
  end

end
