#coding=utf-8
class SessionController < ApplicationController
  def login_with_key
    key = params[:key]
    user = User.where(:key=>key).first
    if user
      session[:user_id] = user.id
      redirect_to page_path('home')
    else
      flash[:login_with_key_message] = '钥匙不对'
      redirect_to page_path('outdoor')
    end
  end

  def login_with_email
    email = params[:email]
    pass = params[:pass]
    user = User.check_pass(email,pass)

    if user
      session[:user_id] = user.id
      redirect_to page_path('home')
    else
      flash[:login_with_email_message] = 'email或密码错'
      redirect_to page_path('outdoor')
    end
  end

  def destroy
    session.clear
    redirect_to page_path('bye')
  end
end

