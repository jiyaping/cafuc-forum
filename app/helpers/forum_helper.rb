module ForumHelper
  def display_as_category(category)
     content=''
     
     url = link_to("#{h category.name}",{:action=>'show_category',:id=>category.id})
     new_post = link_to("发新帖",{:action=>'post',:id=>category.id})
     content<<%(
     <div class="category">
        <p id="name">#{url}<span>#{new_post}&nbsp;&nbsp;
        帖子数:#{Post.root_count(category)}&nbsp;&nbsp;</span></p>
        <p id="description">&nbsp;&nbsp;#{category.description}</p>
     </div>)
     content
  end
  
  def display_as_post(post)
      content=''
      if post.if_top
          if_top = "顶"
      else
          if_top = ""
      end 
      user = User.find(post.user_id)
      url_post = link_to("#{h post.subject}",{:action=>'show_post',:id=>post.id})
      url_user = link_to("#{user.username}",{:controller=>'user',:action=>'show',:id=>user.id})
      content<<%(
      <tr>
      <td class="row">#{if_top}</td>
      <td class="row">#{url_post}</td>
      <td class="row">#{url_user}</td>
      <td class="row">#{post.children_count}</td>
      <td class="row">#{post.view_times}</td>
      <td class="row">#{post.updated_at.strftime("%Y年%M月%d日 %H:%M:%S")}</td>
      </tr>
      )
      content
  end
  
  def display_as_detialPost(post)
      content=''
      user = User.find(post.user_id)
      username = user.username
      user_posts = Post.find(:all,:conditions=>"user_id=#{post.user_id}")
      user_register_time = user.created_at.strftime("%Y年%M月%d日 %H:%M:%S")
      url_user = link_to("#{username}",{:action=>'show_user',:id=>username})
      title = "帖子:"+post.subject
      if Post.if_root?(post)
        sub_title = ""
      else
        parent_post = Post.find(post.parent_id)
        parent_user=User.find(parent_post.user_id)
        sub_title = "回复:"+parent_user.username+"    "+parent_post.subject
      end
      
      reply_url = link_to("回复",{:action=>'reply',:id=>post.id})
      content<<%(
      <div class="showDetialPost">
        <div id="righttop">
        <span>#{title}</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span>#{sub_title}</span>
        <span></span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span>#{post.created_at.strftime("%Y年%M月%d日 %H:%M:%S")}</span>
        <span id="replyLocation">#{reply_url}</span>
        </div>
        <div id="rightbButtom">
        <p>&nbsp;&nbsp;#{post.body}</p>
        </div>
        <div id="leftTop">
        <p>#{url_user}</p>
        <p><span>注册时间:</span><br/>&nbsp;&nbsp;<span>#{user_register_time}</span></p>
        <p><span>发帖数:</span><br/>&nbsp;&nbsp;<span>#{user_posts.size}</span></p>
        </div>
      </div>
      )
      content
  end
  
  def display_as_threads(posts)
    content = ''
    for post in posts
      url = link_to("#{h post.subject}", {:action => 'show', :id => post.id})
      margin_left = post.depth*20
      content << %(
      <div style="margin-left:#{margin_left}px">
        #{url} by #{h post.name} &middot; #{post.created_at.strftime("%H:%M:%S %Y-%M-%d") }
      </div>)
    end
    content
  end
  
end
