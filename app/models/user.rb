require 'tidao'

class User < ActiveRecord::Base
  USER_ROOT = File.expand_path('../../../tidao/users', __FILE__)
  
  def User.create_key
    n = 0
    while n < 5
      key = TiDao::Key.new.to_s
      if User.where(:key=>key).empty?
        User.create(:key=>key)
        return key
      end
      n += 1
    end
    return nil
  end

  def root
    dir = "#{USER_ROOT}/#{self.id}"
    unless File.exist?(dir)
      require 'fileutils'
      FileUtils.mkdir_p(dir)
    end
    return dir
  end
end
