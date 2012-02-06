class AuthenticationsController < ApplicationController

  def create

    omniauth = parse_omniauth(request.env["omniauth.auth"])
    #return render :json => omniauth
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if authentication and not current_user
      #login current_user
      flash[:notice] = "Has ingresado correctamente."
    end

    if not authentication and current_user
      #add authentication to current_user
      #todo: allow only one provider
      
      authentication = current_user.authentications.create(omniauth)
      flash[:notice] = "Se ha agregado #{omniauth['provider']} como medio de ingreso."
    end

    if not authentication and not current_user
      #create/find user and add authentication
      user_by_email = User.find_by_email(omniauth['email'])
      if user_by_email
        #add authentication to user_by_email and log him in
        authentication = user_by_email.authentications.create(omniauth)
        #in case that the user hasnt confirmed his account
        user_by_email.skip_confirmation!
        flash[:notice] = "Se ha agregado #{omniauth['provider']} como medio de ingreso al usuario #{omniauth['email']}."
      else
        #create user, add authentication and log him in
        user = User.new
        user.email = omniauth['email']
        user.name = omniauth['name']
        user.avatar = omniauth['image']
        user.authentications.build(omniauth)
        user.skip_confirmation!
        user.save!
        authentication = user.authentications.first
        flash[:notice] = "Usuario #{omniauth['email']} creado a traves de #{omniauth['provider']} como medio de ingreso."
      end
    end
    
    authentication.attributes = omniauth
    authentication.save
    user = authentication.user
    user.avatar ||= authentication.image
    user.name ||= authentication.name
    user.save
    
    #if authentication and authentication_has_changed
      #update authentication fields
    #end
    
    sign_in_and_redirect(:user, user)
    
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "La opcion de autentificacion ha sido eliminada."
    redirect_to profile_url
  end
  
  private
  
  def parse_omniauth(omniauth)
    r = {}
    r['provider'] = omniauth['provider']
    r['uid'] = omniauth['uid']
    r['email'] = omniauth['info']['email']
    r['image'] = omniauth['info']['image']
    r['name'] = omniauth['info']['name']
    r['token'] = omniauth['credentials']['token']
    r['secret'] = (omniauth['credentials']['secret'] rescue '')
    r
  end
  
end
