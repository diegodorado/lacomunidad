class VideosController < ApplicationController

  before_filter :authenticate_user!, :check_perms
  
  def check_perms
    authorized = [ 'diegodorado@gmail.com', 'carlos@redhumanista.org', 'joseluismiranda@gmail.com','gabiyas@gmail.com', 'julietaspagnuolo@yahoo.com.ar' ]
    redirect_to root_path, :alert =>  "No tienes permisos suficientes." unless authorized.include?(current_user.email)
  end
  

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      redirect_to @video, :notice => "Successfully created video."
    else
      render :action => 'new'
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      redirect_to @video, :notice  => "Successfully updated video."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_url, :notice => "Successfully destroyed video."
  end
end
