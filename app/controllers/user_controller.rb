class UserController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def migration
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
      if User.is_password_ok(@user) && User.is_unique(@user)
      if @user.save
        flash[:notice] = '用户成功的创建.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    else
        flash[:error]="密码不符或者用户已存在"
        render :action=>'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = '用户成功的更新'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def login
      if request.post?
          user = User.is_a_user(params[:username],params[:password])
          if user
              session[:user_id]=user.id
              flash[:notice]="登录成功"
              redirect_to :controller=>'forum',:action=>'index'
          else
              flash[:notice]="用户名或密码出现错误"
          end
      end
  end
  
  def logout
      session[:user_id]=nil
      @@user=nil
      redirect_to :controller=>'forum',:action=>'index'
  end
  
  def profile
      redirect_to :controller=>'user',:action=>'show',:id=>session[:user_id]
  end
end


















