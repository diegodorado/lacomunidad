class PagesController < ApplicationController

  helper_method :has_perms?

  def show
    @page = Page.find params[:id]
    redirect_to root_path, :alert =>  "La pagina '#{params[:id]}' no existe" unless @page
  end

  def new
    @page = Page.new
  end

  def edit
    #return not_allowed unless has_perms?
    @page = Page.find( params[:id])
  end

  def create
    page = Page.new(params['page'])
    page.save
    redirect_to page
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
    redirect_to root_path, :alert =>  "La pagina '#{params[:id]}' se elimino"
  end

  protected

  def has_perms?
    true
  end


end
