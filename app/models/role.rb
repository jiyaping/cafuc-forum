class Role < ActiveRecord::Base
    has_many :users
    
    def self.role_name(role_id)
        Role.find(role_id).role_name
    end
end
