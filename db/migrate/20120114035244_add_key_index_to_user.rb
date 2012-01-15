class AddKeyIndexToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.index(:key,:unique=>true)
      t.index(:email,:unique=>true)
    end
  end
end
