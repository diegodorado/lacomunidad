class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = parse_omniauth(request.env["omniauth.auth"])
    
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.apply_omniauth(omniauth)
      flash[:notice] = "Authentication successful."
      redirect_to profile_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth      
        redirect_to new_user_registration_url
      end
    end
    
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to profile_url
  end
  
  private
  
  def parse_omniauth(omniauth)
  
    if omniauth['provider'] == 'facebook'
      omniauth['email'] = omniauth['extra']['user_hash']['email']
      omniauth['image'] = 'https://graph.facebook.com/'+omniauth['uid']+'/picture?type=large'
    else
      omniauth['email'] = omniauth['user_info']['email']
      omniauth['image'] = omniauth['user_info']['image']
    end

    omniauth['name'] = omniauth['user_info']['name']
    omniauth['nickname'] = omniauth['user_info']['nickname']
    omniauth['token'] = omniauth['credentials']['token']
    omniauth['secret'] = omniauth['credentials']['secret']
    
    omniauth.delete('user_info')
    omniauth.delete('credentials')
    omniauth.delete('extra')

    omniauth
  end
  
end
