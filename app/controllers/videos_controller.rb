class VideosController < ApplicationController

  load_and_authorize_resource

  def create
    if @video.save
      redirect_to videos_path, :notice => "Video #{@video.title} creado."
    else
      render :action => 'new'
    end
  end


  def update
    if @video.update_attributes(params[:video])
      redirect_to videos_path, :notice => "Video #{@video.title} creado."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_path, :notice => "Successfully destroyed video."
  end
  
end
