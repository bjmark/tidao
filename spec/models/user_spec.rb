require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'User.new_key' do
    specify do
      defined?(TiDao).should be_true
      #TiDao::Key.new.to_s.length.should == 32
      User.new_key.length.should == 32
    end
  end
end
