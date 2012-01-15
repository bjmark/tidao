class NotesController < ApplicationController
  before_filter :check_session

  def index
    @files = Note.new(cur_user).index
  end

  def show
    id = params[:id]
    note = Note.new(cur_user)
    @name,@content = note[id]
    @id = id
  end

  def new
  end

  def create
    note = Note.new(cur_user)
    id = note.create(params[:file_name],params[:content])

    redirect_to note_path(id)
  end
end
