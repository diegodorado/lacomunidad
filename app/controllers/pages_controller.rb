class PagesController < ApplicationController

  helper_method :has_perms?, :pages_viewed_titles
  before_filter :authenticate_user!, :except => [:show]

  def show
    @page = Page.find params[:id] rescue redirect_to root_path, :alert =>  "La pagina '#{params[:id]}' no existe"
    pages_viewed(@page)
  end

  def index
    redirect_to root_path, :alert =>  "No tienes permisos suficientes." unless has_perms?
    @pages = Page.order(:title).all
  end

  def new
    p = Page.new
    p.title = params[:title]
    p.save
    redirect_to edit_page_path(p), :notice =>  "Pagina creada. Agregale contenido."
  end

  def edit
    @page = Page.find( params[:id])
    redirect_to @page unless has_perms?
  end

  def update
    page = Page.find params[:id]
    redirect_to page unless has_perms?
    page.update_attributes(params[:page])
    page.save
    redirect_to page
  end

  def destroy
    page = Page.find params[:id]
    redirect_to page unless has_perms?
    page.destroy
    redirect_to root_path, :notice =>  "La pagina '#{params[:id]}' se elimino"
  end

  protected

  def has_perms?
    return false unless user_signed_in?
    authorized = [ 'diegodorado@gmail.com', 'carlos@redhumanista.org', 'joseluismiranda@gmail.com','gabiyas@gmail.com', 'julietaspagnuolo@yahoo.com.ar' ]
    authorized.include?(current_user.email)
  end

  def pages_viewed(page)
    session[:pages_viewed_titles] ||= []
    if page
      #session[:pages_viewed_titles].delete page.title 
      session[:pages_viewed_titles] << page.title unless session[:pages_viewed_titles].include?(page.title)
    end
    session[:pages_viewed_titles].shift if session[:pages_viewed_titles].size > 6
  end

  def pages_viewed_titles
    session[:pages_viewed_titles].reject { |t| t.parameterize == params[:id]}
    #session[:pages_viewed_titles]
  end



end
