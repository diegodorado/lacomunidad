class CandidatesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]
  before_filter :check_candidates_time, :only => [:new, :create, :destroy]

  load_and_authorize_resource

  def index
    @list = params[:list]
    @results = params[:results]
  end

  def votes_result
    redirect_to root_path, :alert => "..........dddd......"
  end

  def new
    if cannot? :manage, @candidate
      if current_user.candidate then
        #already created
        redirect_to edit_candidate_path current_user.candidate
      else
        @candidate.user = current_user
      end
    end
  end

  def create
    if @candidate.save
      redirect_to root_path, :notice => "Recibimos tu postulacion."
    else
      render :action => 'new'
    end
  end

  def update
    if @candidate.update_attributes(params[:candidate])
      redirect_to root_path, :notice => "Actualizaste tu postulacion."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @candidate.destroy
    redirect_to root_path, :notice => "Eliminaste tu postulacion."
  end



  def vote
    current_user.vote_exclusively_for(@candidate)
    redirect_to candidates_path @candidate, :notice => "Diste tu voto a #{@candidate.user.name}."
  end

  def unvote
    current_user.clear_votes(@candidate)
    redirect_to candidates_path @candidate, :notice => "Revocaste tu voto a #{@candidate.user.name}."
  end


  private
  
  
  def check_candidates_time
    return if can? :manage, Candidate
    starts_at = Setting.candidates_starts_at
    ends_at = Setting.candidates_ends_at
    unless (starts_at..ends_at).cover?(Time.now)
      redirect_to root_path, :alert => "Las postulaciones son entre el #{I18n.l(starts_at)} y el #{I18n.l(ends_at)}."
    end
    
    rescue StandardError => err
      redirect_to root_path, :alert => "Aun no esta configurada esta seccion. #{err}"
  end
  
  def check_votes_time
    return if can? :manage, Candidate
    starts_at = Setting.votes_starts_at
    ends_at = Setting.votes_ends_at
    unless (starts_at..ends_at).cover?(Time.now)
      redirect_to root_path, :alert => "Las votaciones son entre el #{I18n.l(starts_at)} y el #{I18n.l(ends_at)}."
    end   

    rescue StandardError => err
      redirect_to root_path, :alert => "Aun no esta configurada esta seccion. #{err}"
  end
  
  
end
