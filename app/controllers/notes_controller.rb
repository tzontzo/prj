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
    @note = Note.new(note_params)
    @user = User.find(session[:id])
    @note.update_attributes(user_id: @user.id)
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
