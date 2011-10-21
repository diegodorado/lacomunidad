class StaticController < ApplicationController
  def home
  end

  def docs
    redirect_to page_path('documentos')
  end

  def news
    redirect_to page_path('noticias')
  end

  def participate
  end

  def what
    redirect_to page_path('que-es-la-comunidad')
  end

end
