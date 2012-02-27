class AudiosController < ApplicationController

  before_filter :authenticate_user!, :check_perms
  
  def check_perms
    authorized = [ 'diegodorado@gmail.com', 'carlos@redhumanista.org', 'joseluismiranda@gmail.com','gabiyas@gmail.com', 'julietaspagnuolo@yahoo.com.ar' ]
    redirect_to root_path, :alert =>  "No tienes permisos suficientes." unless authorized.include?(current_user.email)
  end
  

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
