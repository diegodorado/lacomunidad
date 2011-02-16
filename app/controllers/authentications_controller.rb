class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def create
    render :text => request.env['omniauth.auth'].to_yaml
=begin  
    @authentication = Authentication.new(params[:authentication])
    if @authentication.save
      flash[:notice] = "Successfully created authentication."
      redirect_to authentications_path
    else
      render :action => 'new'
    end
    
=end
    
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
