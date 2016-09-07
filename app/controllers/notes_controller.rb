class NotesController < ApplicationController
  def index
  end
  def show
    @note = Note.find(params[:id])
  end
  def new
    @note = Note.new
  end
  def create
    params = note_params
    params[:user_id] = @logged_user["id"]
    @note = Note.new(params)
    if @note.save
      session[:note_id] =@note.id
      redirect_to :back
    else
      redirect_to '/'
    end
  end
  def destroy
    @note= Note.find(params[:id])
    @note.destroy
    redirect_to :back
  end
  private
  def note_params
    params.require(:note).permit(:note_type,:content)
  end
end
