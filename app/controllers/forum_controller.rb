class ForumController < ApplicationController
    def index
        @category = Category.find(:all)
    end
    
    def post
        @post = Post.new
        @post.category_id = params[:id]
        if !session[:user_id].nil? 
            @post.user_id = session[:user_id]
        else
            flash[:notice]= "请先登陆再发帖子"
            redirect_to :controller=>'user',:action=>'login'
        end
    end
    
    def create
        @post = Post.new(params[:post])
        if @post.save
            redirect_to :action=>'show_category',:id=>@post.category.id
        else
            redirect_to :action=>'post'
        end
    end
    
    def show_category
        @post_pages, @posts = paginate :posts, :per_page => 20, :order => 'root_id desc, lft',
            :conditions=>"category_id=#{params[:id]} and id=root_id"
    end
    
    def show_post
        post = Post.find(params[:id])
        post.view_times=post.view_times+1
        post.save
        @posts = Post.find(:all,:conditions=>"root_id=#{post.root_id}")
        
        #render :text=>Post.if_root?(@posts[0]).to_s
    end
    
    def reply
        reply_to = Post.find(params[:id])
        category_id = reply_to.category_id
        if !session[:user_id].nil? 
            @page_title = "回复 '#{reply_to.subject}'"
        @post = Post.new({:parent_id => reply_to.id,:category_id=>category_id,:user_id=>session[:user_id]})
        else
            flash[:notice]= "请先登陆再发回帖"
            redirect_to :controller=>'user',:action=>'login'
        end
        #render :text=>"#{category_id}"
        
        render :action => 'post'
    end
    
end








