class AddPasswordConfirmToUser < ActiveRecord::Migration
  def self.up
      add_column :users,:password_confirm,:string
  end

  def self.down
      remove_column :users,:password_confirm
  end
end
