class Post < ActiveRecord::Base
	belongs_to :category
    has_many :special_posts
    
	acts_as_threaded

	validates_length_of :subject, :within => 3..255
	validates_length_of :body, :within => 5..5000

	def self.find_all_in_category(category)
	  category = Category.find_by_name(category);
	  self.find :all,:conditions=>"category_id=#{category.id}"
	end
	
	def self.root_count(category)
	    Post.find(:all,:conditions=>"category_id=#{category.id} and root_id=id").size
    end
    
    def self.if_root?(post)
        post.root_id==post.id
    end
    
    def self.role_name(post)
        Role.find(post.role_id).role_name
    end
end

