#coding=utf-8
class SessionController < ApplicationController
  def new
    if params[:key] == 'no'
      @key = User.create_key
    end
  end

  def create
    key = params[:key]
    user = User.where(:key=>key).first
    if user
      session[:user_id] = user.id
      redirect_to page_path('home')
    else
      @error = '钥匙不对'
      render :action=>'new'
    end
  end

  def destroy
    session.clear
    redirect_to page_path('bye')
  end
end

