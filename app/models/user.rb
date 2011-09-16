class User < ActiveRecord::Base
    belongs_to :role
    has_many :special_posts
    
    def self.is_unique(user)
        if User.find_by_username(user.username)
            return false
        else
            return true
        end
    end
    
    def self.is_password_ok(user)
        if user.password == user.password_confirm
            return true
        else
            return false
        end
    end
    
    def self.is_a_user(username,password)
        user = User.find_by_username(username)
        if user.password == password
            return user
        else
            return false
        end
    end
end
