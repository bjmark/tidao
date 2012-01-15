class NotesController < ApplicationController
  before_filter :check_session

  def index
    @files = Note.new(cur_user).index
  end

  def show
    id = params[:id].to_i
    note = Note.new(cur_user)
    @name,@content = note[id]
    @id = id
  end

  def new
  end

  def create
    note = Note.new(cur_user)
    id = note.create(params[:name],params[:content])

    redirect_to note_path(id)
  end

  def edit
    id = params[:id].to_i
    note = Note.new(cur_user)
    @name,@content = note[id]
    @id = id
  end

  def update
    id = params[:id].to_i

    note = Note.new(cur_user)
    note.update(id,params[:name],params[:content])

    redirect_to note_path(id)
  end

  def destroy
    id = params[:id].to_i

    note = Note.new(cur_user)
    note.del(id)

    redirect_to notes_path
  end
end
