class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    
    can :manage, :all  if user.role? :admin
    
    #a user can edit his account
    can :manage, User, :id => user.id

    can :manage, User if user.role? :admin
    can :manage, Book if user.role? :book_editor

    can :read , Candidate

    if Setting.candidates_season and user.role? :member
      can [:edit,:new, :destroy] , Candidate, :user_id => user.id
    end
    
    if Setting.votes_season and user.role? :member
      can [:vote,:unvote] , Candidate
    end
    
    can :votes_result , Candidate if Setting.votes_result_season

    #redirect_to root_path, :alert => "Las postulaciones son entre el #{I18n.l(starts_at)} y el #{I18n.l(ends_at)}."
    #rescue StandardError => err
    #redirect_to root_path, :alert => "Aun no esta configurada esta seccion. #{err}"
    #redirect_to root_path, :alert => "Las votaciones son entre el #{I18n.l(starts_at)} y el #{I18n.l(ends_at)}."
    
    can :create, Candidate if user.role? :member
    can :update, Candidate if user.role? :member

    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
