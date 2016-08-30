class CommentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])

  end
  def new
    @task = Task.find(params[:id])
    @comment = Comment.new
  end
  def show
   @comment = Comment.find(params[:id])
  end
  def create
    @comment = Comment.new(comment_params)
    @task = Task.find(params[:task_id])
    @user = User.find(session[:id])
    @comment.update_attributes(user_id: @user.id,task_id: @task.id)
    if @comment.save
      session[:comment_id] =@comment.id
      redirect_to :back
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
  def comment_params
    params.require(:comment).permit(:content)
  end
end
