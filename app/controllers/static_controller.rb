class StaticController < ApplicationController
  def docs
    @videos = DOCS['videos']
  end
end
