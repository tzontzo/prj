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

  end
  def edit

  end
  def update

  end
  def delete

  end
  private
  def task_params
    params.require(:comment).permit(:content)
  end
end
