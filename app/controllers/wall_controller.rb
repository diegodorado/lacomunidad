class WallController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index]
  respond_to :html, :js
  def index
    @posts = Post.order('created_at desc').all
  end

  def create
    @post = Post.new(params['post'])
    if @post.save
      respond_to do |format| #      respond_with(@post) do |format|
        format.js   { render :layout => false }
      end
    end
  end
  
end
