require 'tidao'

class User < ActiveRecord::Base
  def User.new_key
    n = 0
    while n < 5
      key = TiDao::Key.new.to_s
      return key if User.where(:key=>key).empty?
      n += 1
    end
    return nil
  end
end
