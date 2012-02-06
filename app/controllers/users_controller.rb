class UsersController < ApplicationController
  respond_to :json

  def index
    return render :json => User.user_list.to_json
  end

# todo: move over
  def profile
    @user = current_user
  end

  def profile_pic
    provider = params['provider']
    u = current_user
    case provider
      when 'gravatar'
        u.avatar = u.gravatar
      when 'facebook'
        u.avatar = u.facebook_authentication.image
      when 'google'
        u.avatar = u.google_authentication.image
    end
    u.save
    flash[:notice] = "Ahora usas la imagen de #{provider}."
    redirect_to profile_url    
  end

  def profile_name
    name = params['name']
    u = current_user
    u.name = name
    u.save
    flash[:notice] = "Ahora tu nombre es #{name}."
    redirect_to profile_url    
  end
  
end
