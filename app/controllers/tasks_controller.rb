class TasksController < ApplicationController
  def index
    @project= Project.find(params[:project_id])
    @user = User.find(session[:user_id])
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
    @task.time_worked =0
    cookies[:status]
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
    @task.update_attributes({started_at: Time.now, status: "started"})

    redirect_to :back

  end
  def pause_task
    @task = Task.find(params[:id])
    @paused = Time.now.to_i
    @started = @task.started_at.to_i
    @worked = @task.time_worked.to_i
    @t_worked = Time.at(@worked+ (@paused - @started))
    @task.update_attributes({paused_at: @paused,time_worked: @t_worked, status: "paused"})

    redirect_to :back
  end
  def stopped_task
    @task = Task.find(params[:id])
    @task.ended_at = Time.now
    @ended = @task.ended_at
    @started = @task.started_at
    @worked = @task.time_worked
    @t_worked = Time.at(@worked.to_i + (@ended.to_i - @started.to_i))
    @task.update_attributes({ended_at: @ended,time_worked: @t_worked, status: "ended"})
    redirect_to :back
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
