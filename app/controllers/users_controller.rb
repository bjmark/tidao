#coding=utf-8
class UsersController < ApplicationController
  before_filter :check_session,:except=>[:new_key,:create_key]

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

  def show
    @user = cur_user
  end

  def update
    @user = cur_user
    case 
    when params[:save_user_name]
      @user.name = params[:name]
      @user.save
      @name_message = '保存成功'
    when params[:save_user_email]
      if (u = User.find_by_email(params[:email])) and u.id != @user.id
        @email_message = 'email已存在！'
      else
        @user.email = params[:email]
        @user.save
        @email_message = '保存成功'
      end
    when params[:save_user_pass]
      @user.password = params[:pass]
      @user.save
      @pass_message = '保存成功'
    end

    render :action=>'show'
  end
end
