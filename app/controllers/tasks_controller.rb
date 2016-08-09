class TasksController < ApplicationController
  def index
    end
  def new
    @task = Task.new
  end
  def create
    @project = Project.find(params[:project_id])
    @user = User.find(session[:user_id])
    @task = Task.new(task_params)
    @task.users << @user
    @task.project_id= @project.id
    if @task.save
      session[:task_id] =@task.id
      redirect_to project_tasks_path
    else
      redirect_to '/'
    end
  end
  def edit

  end
  def update

  end
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to :back
  end
  private
  def task_params
    params.require(:task).permit(:title,:details)
  end
end
