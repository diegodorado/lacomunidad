class SettingsController < ApplicationController
  authorize_resource :class => Setting
  respond_to :html, :js
  
  def change
    @key = params[:key]
    @value = params[:value]
    @value = @value.to_time if params[:date]
    Setting[@key] = @value
    #redirect_to settings_path, :notice => "Valor actualizado #{params[:key]}=>'#{value}'"
  end
  
end
