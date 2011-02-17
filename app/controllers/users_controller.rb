class UsersController < ApplicationController
  def profile
    @authentications = current_user.authentications if current_user

    @user = current_user
    @user.update_attributes(params[:user])
    @user.save!
  end
end
