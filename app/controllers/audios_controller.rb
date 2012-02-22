class AudiosController < ApplicationController
  def index
    @audios = Audio.all
  end

  def show
    @audio = Audio.find(params[:id])
  end

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.new(params[:audio])
    if @audio.save
      redirect_to @audio, :notice => "Successfully created audio."
    else
      render :action => 'new'
    end
  end

  def edit
    @audio = Audio.find(params[:id])
  end

  def update
    @audio = Audio.find(params[:id])
    if @audio.update_attributes(params[:audio])
      redirect_to @audio, :notice  => "Successfully updated audio."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy
    redirect_to audios_url, :notice => "Successfully destroyed audio."
  end
end
