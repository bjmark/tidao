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

  def password=(pass)
    return if pass.blank?

    self.salt = self.object_id.to_s + rand.to_s
    self.hashed_pass = User.encrypt_password(pass, self.salt)
  end

  def User.encrypt_password(pass, salt)
    Digest::SHA2.hexdigest(pass + "mark" + salt)
  end

  def User.check_pass(email,pass)
    return nil unless u = User.find_by_email(email)
    if u.hashed_pass == User.encrypt_password(pass, u.salt)
      return u
    end
    return nil
  end

end
