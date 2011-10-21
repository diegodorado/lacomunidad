class PagesController < ApplicationController

  helper_method :has_perms?
  before_filter :authenticate_user!, :except => [:show]

  def show
    @page = Page.find params[:id] rescue redirect_to root_path, :alert =>  "La pagina '#{params[:id]}' no existe"
  end

  def new
    p = Page.new
    p.title = params[:title]
    p.save
    redirect_to edit_page_path(p), :notice =>  "Pagina creada. Agregale contenido."
  end

  def edit
    #return not_allowed unless has_perms?
    @page = Page.find( params[:id])
  end

  def update
    page = Page.find params[:id]
    page.update_attributes(params[:page])
    page.save
    redirect_to page
  end

  def destroy
    page = Page.find params[:id]
    page.destroy
    redirect_to root_path, :notice =>  "La pagina '#{params[:id]}' se elimino"
  end

  protected

  def has_perms?
    return false unless user_signed_in?
    current_user.email == 'diegodorado@gmail.com'
  end


end
