#coding=utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_session
    (redirect_to(page_path('outdoor')) and return) unless session[:user_id]
  end

  def login?
    return session[:user_id]
  end

  def cur_user
    @cur_user ||= User.find(session[:user_id])
  end
end
