class StaticController < ApplicationController
  def home
    @blog_post = BlogPost.limit(1).order('created_at desc').first
    @blog_posts = BlogPost.where('id not in (?)', @blog_post.id).limit(4).order('created_at desc') if @blog_post
    @posts = Post.includes([:comments, :votes]).order('created_at desc').limit(10)
  end

  def docs
    redirect_to docs_videos_path
  end
  def docs_videos
    @videos = Video.all
  end
  def docs_books
    @books = Book.order('title').all
  end
  def docs_xgs
    @xgs = Audio.order('title').all
  end
end
