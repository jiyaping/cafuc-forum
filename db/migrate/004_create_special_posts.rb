class CreateSpecialPosts < ActiveRecord::Migration
  def self.up
    create_table :special_posts do |t|
        t.column :post_id, :integer,:null=>false
        t.column :special, :string
        t.column :user_id, :integer,:null=>false
    end
  end

  def self.down
    drop_table :special_posts
  end
end
