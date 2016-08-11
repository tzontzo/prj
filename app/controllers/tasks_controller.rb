class TasksController < ApplicationController
  def index

  end

  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    @project = Project.find(params[:project_id])
    @user = User.find(session[:user_id])
    @task.users << @user
    @task.project_id= @project.id
    @task.status = "not started"
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
  def start_task
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.started_at = Time.now
    @task.status = "started"
    redirect_to :back

  end
  def pause_task
    @task = Task.find(params[:id])
    @task.paused_at = Time.now
    @paused = @task.paused_at
    @started = @task.started_at
    @worked = @task.time_worked
    @task.time_worked = @worked + (@paused- @started)
    @task.status = "paused"
  end
  def stopped_task
    @task = Task.find(params[:id])
    @task.ended_at = Time.now
    @ended = @task.ended_at
    @started = @task.started_at
    @worked = @task.time_worked
    @task.time_worked = @worked + (@ended- @started)
    @task.status = "ended"
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
