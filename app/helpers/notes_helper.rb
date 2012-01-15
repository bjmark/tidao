module NotesHelper
  def note_form_path
    if @name
      return note_path(@id)
    else
      return notes_path
    end
  end

  def note_form_opt
    if @name
      {:method=>:put}
    else
      {}
    end
  end
end
