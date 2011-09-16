class AddLastLogTime < ActiveRecord::Migration
  def self.up
      add_column :users,:lastest_login,:datetime
  end

  def self.down
      remove_column :users,:lastest_login
  end
end
