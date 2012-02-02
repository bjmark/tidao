class AddHashedPassToUser < ActiveRecord::Migration
  def change
    add_column :users,:hashed_pass,:string
    add_column :users,:salt,:string
  end
end
