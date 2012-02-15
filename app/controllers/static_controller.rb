class StaticController < ApplicationController

  def docs
    @videos = DOCS['videos']
  end
  
  def news
    redirect_to page_path('noticias')
  end

  def participate
    redirect_to page_path('como-participar')
  end

  def what
    redirect_to page_path('que-es-la-comunidad')
  end

end
