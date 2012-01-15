class PagesController < ApplicationController
  before_filter :check

  def check
    if ['home'].include?(params[:id])
      check_session()
    end
  end

  def show
    id = params[:id]
    if id.blank?
      if login?
        id = 'home'
      else
        id = 'outdoor'
      end
    end
    render id
  end
end
