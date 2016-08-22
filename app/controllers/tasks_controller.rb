class TasksController < ApplicationController
  def index
    @project= Project.find(params[:project_id])
    @user = User.find(session[:id])
  end
  def show
    @task = Task.find(params[:id])
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    @project = Project.find(params[:project_id])
    @user = User.find(session[:id])
    @task.users << @user
    @task.update_attributes({creator_id: @user.id,project_id: @project.id,status: "not started", time_worked: 0})
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
    @task = Task.find(params[:id])
    if @task.status == "not started"
      @task.update_attributes({started_at: Time.now, status: "started"})
    end
      @task.update_attributes({pause_ended_at: Time.now, status: "started"})
    redirect_to :back
  end

  def pause_task
    @task = Task.find(params[:id])
    @paused = Time.now.to_i
    @pause_ended = @task.pause_ended_at.to_i
    @worked = @task.time_worked.to_i
    @t_worked = Time.at(@worked+(@paused - @pause_ended))
    @task.update_attributes({pause_started_at: @paused,time_worked: @t_worked, status: "paused"})
    redirect_to :back
  end

  def stopped_task
    @task = Task.find(params[:id])
    if @task.status == "started"
      @task.ended_at = Time.now
      @ended = @task.ended_at.to_i
      @pause_ended = @task.pause_ended_at.to_i
      @worked = @task.time_worked.to_i
      @t_worked = @worked +(@ended - @pause_ended)
      @task.update_attributes({ended_at: @ended,time_worked:Time.at( @t_worked), status: "ended"})
    end
    @task.update_attributes({status: "ended"})
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
