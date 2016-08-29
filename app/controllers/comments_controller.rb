class CommentsController < ApplicationController
  def index
  end
  def new
    @comment = Comment.new
  end
  def show
   @comment = Comment.find(params[:id])
  end
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(comment_params)

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
