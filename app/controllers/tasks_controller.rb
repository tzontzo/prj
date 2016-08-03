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
      if @user.role== 'team leader'
        redirect_to '/team_leader'
      else
        redirect_to '/programmer'
      end
    else
      redirect_to '/'
    end
  end
  def edit

  end
  def update

  end
  def delete

  end
  private
  def task_params
    params.require(:task).permit(:title,:details)
  end
end
