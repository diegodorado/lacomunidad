class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :ensure_domain

  APP_DOMAIN = 'lacomunidad.org.ar'

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end  


  def ensure_domain
    if request.env['HTTP_HOST'] != APP_DOMAIN && Rails.env.production?
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
end
