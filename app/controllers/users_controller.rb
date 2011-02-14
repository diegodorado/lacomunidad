class UsersController < ApplicationController
  def profile
    @user = current_user
    @user.update_attributes(params[:user])
    @user.save!
  end
end
