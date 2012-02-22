class StaticController < ApplicationController
  def docs
    @videos = Video.all
    @books = Book.order('title').all
    @audios = Audio.order('title').all
  end
end
