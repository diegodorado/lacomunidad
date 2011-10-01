class PagesController < ApplicationController

  helper_method :has_perms?

  def index
    @pages = Page.order('title')
  end

  def show
    @page = Page.find_by_path_or_new( params[:path] )
    render ( @page.new_record? ? 'empty' : 'show' )
  end

  def new
    @page = Page.find_by_path_or_new( params[:path] )
    return not_allowed unless has_perms?
  end

  def edit
    return not_allowed unless has_perms?
    @page = Page.find( params[:id])
  end

  def create
    return not_allowed unless has_perms?
    page = Page.new(params['page'])
    page.save
    redirect_to show_page_path( page.path)
  end

  def update
    return not_allowed unless has_perms?
    page = Page.find(params[:id])
    page.update_attributes(params[:page])
    page.save
    redirect_to show_page_path( page.path)
  end

  def destroy
    return not_allowed unless has_perms?
    page = Page.find( params[:id])
    page.destroy
    redirect_to url_for( :action => :index )
  end

  def not_allowed
  end

  protected

  def has_perms?
    true
  end


end
