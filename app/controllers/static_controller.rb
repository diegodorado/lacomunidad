class StaticController < ApplicationController
  def home
    #@posts = Post.plusminus_tally.limit(5).where('created_at > ?', 1.month.ago).having('plusminus > 10')  
    @posts = Post.plusminus_tally.limit(5).order('created_at desc')
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
