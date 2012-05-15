class AudiosController < ApplicationController

  load_and_authorize_resource

  def create
    if @audio.save
      redirect_to audios_path, :notice => "Audio #{@video.title} creado."
    else
      render :action => 'new'
    end
  end

  def update
    if @audio.update_attributes(params[:audio])
      redirect_to audios_path, :notice => "Audio #{@video.title} actualizado."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @audio.destroy
    redirect_to audios_path, :notice => "Successfully destroyed audio."
  end
end
