#coding=utf-8
class UsersController < ApplicationController
  def new_key
    @a = rand(100) % 20 + 1
    @b = rand(@a+1000) % 20  + 1
    flash[:express] = "#{@a}+#{@b}"
  end
  
  def create_key
    s = flash[:express]
    a,b = s.split('+')
    if a.to_i + b.to_i == params[:value].to_i
      @key = User.create_key
    else
      flash[:note] = '您要不就是没算，要不就是没算对。请认真计算下面算式的结果：'
      redirect_to new_key_user_path
    end
  end
end
