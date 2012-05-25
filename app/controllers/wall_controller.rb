class WallController < ApplicationController
  #before_filter :authenticate_user!
  # making wall public
  respond_to :html
  
  def index
    @posts = Post.includes([:comments, :votes]).order('created_at desc').limit(10)
  end

end
