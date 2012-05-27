class UsersController < ApplicationController
  respond_to :json

  before_filter :authenticate_user!

  load_and_authorize_resource

  def profile
    @user = current_user
  end

  def change_pic
    provider = params['provider'].to_sym
    @user.change_pic provider
    redirect_to profile_user_url(@user), :notice => "Ahora usas la imagen de #{provider}."
  end

  def change_name
    name = params['name']
    @user.change_name name
    redirect_to profile_user_url, :notice => "Ahora tu nombre es #{name}."
  end

  #manage users roles
  def index
    @users = @users.includes(:roles).order('users.name').not_me(current_user)
    @role = params[:role]
    @users = @users.where('roles.name'=>@role) if @role
    @roles = Role::ROLES
  end

  def toggle_role
    user = User.find(params[:id])
    role = params[:role]
    user.toggle_role role
    redirect_to users_path, :notice => "Ahora #{user.name} es #{user.friendly_roles_name}"
  end

  def votes
    @users = @users.includes(:roles).where('roles.name'=>:member).order('users.name')
    @candidates = Candidate.includes(:votes).all
  end


  
end
