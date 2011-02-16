class WallController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index]
  respond_to :html, :js
  def index
    @posts = Post.order('created_at desc').all
  end

  def create_post
    @post = current_user.posts.build(params['post'])
    if @post.save
      respond_to do |format| #      respond_with(@post) do |format|
        format.js   { render :layout => false }
      end
    end
  end

  def create_comment
    @post = Post.find(params['post_id'])
    @comment = @post.comments.build(params['comment'])
    @comment.user_id = current_user.id
    if @comment.save!
      respond_to do |format|
        format.js   { render :layout => false }
      end
    else
      flash[:notice] = "error"
    end
  end
  
end
