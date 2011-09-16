class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
        t.column :username, :string, :limit=>50, :null=>false
        t.column :password, :string, :limit=>255, :null=>false
        t.column :role_id, :integer, :null=>false,:default=>2
        t.column :lastest_post,:date
        t.column :created_at, :timestamp, :null => false
        t.column :updated_at, :timestamp, :null => false
        t.column :email, :string
        t.column :QQ, :string
        t.column :if_active,:bool,:null=>false,:default=>1
    end
  end

  def self.down
    drop_table :users
  end
end
