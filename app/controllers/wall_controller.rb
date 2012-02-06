class WallController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js
  
  def index
    @users = User.user_list
  end

  def index_old
    return redirect_to root_path, :notice =>  "El muro esta en desarrollo. Pronto estara en funcionamiento." if Rails.env.production? 

    @posts = Post.order('created_at desc').limit(10)
    @view_more_offset = 10

    @popular_posts = Post.tally(
      {  :start_at => 80.weeks.ago,
          :limit => 5,
          :order => "vote_count DESC"
      })

  end

  def view_more_posts
    @offset = params['offset'].to_i
    @view_more_offset = @offset + 10
    @posts = Post.order('created_at desc').limit(10).offset(@offset)
    render :layout => false
  end

  def create_post
    @post = current_user.posts.build(params['post'])
    @post.attachement = nil unless @post.attachement.valid?
    if @post.save
      render :layout => false
    else
      render :text => "$('#alert').text('no se pudo crear la publicacion').fadeOut(2000)"
    end
  end

  def vote_post
    @post = Post.find(params['post_id'])
    current_user.vote(@post, { :direction => params['direction'], :exclusive => current_user.voted_on?(@post) })
    render :layout => false
  end


  def create_comment
    @post = Post.find(params['post_id'])
    @comment = @post.comments.build(params['comment'])
    @comment.user_id = current_user.id
    if @comment.save
      render :layout => false
    else
      render :text => "$('#alert').text('no se pudo grabar el comentario').fadeOut(2000)"
    end
  end

  def view_post_comments
    @post = Post.find(params['post_id'])
    @comments = @post.comments.offset(3)
    render :layout => false
  end

  def create_post_og
    @og = OpenGraph.fetch(params['url'])
    if @og.valid?
      render :layout => false
    else
      #todo: log details
      #todo: enhance parseUri

      return render :text => "$('#alert').text('no es una url valida').fadeOut(2000);"
    end



  end

end
