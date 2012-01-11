class PagesController < ApplicationController
  def show
    id = params[:id]
    id = 'home' if id.blank?
    render id
  end
end
