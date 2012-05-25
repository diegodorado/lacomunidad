class CandidatesController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource :only => [:index]

  def index
    @list = params[:list]
  end

  def votes_result
    @candidates = Candidate.tally
    
  end

  def votes_reset
    Candidate.clear_votes
    redirect_to candidates_path, :notice => "Votos reseteados."
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
      redirect_to candidates_path, :notice => "Recibimos la postulacion."
    else
      render :action => 'new'
    end
  end

  def update
    if @candidate.update_attributes(params[:candidate])
      redirect_to candidates_path, :notice => "Actualizaste la postulacion."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @candidate.destroy
    redirect_to candidates_path, :notice => "Eliminaste la postulacion."
  end



  def vote
    current_user.vote_exclusively_for(@candidate)
    #redirect_to candidates_path @candidate, :notice => "Diste tu voto a #{@candidate.name}."
  end

  def unvote
    current_user.clear_votes(@candidate)
    #redirect_to candidates_path @candidate, :notice => "Revocaste tu voto a #{@candidate.name}."
  end


end
