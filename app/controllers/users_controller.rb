class UsersController < ApplicationController

  def show
    set_user
    @neighborhoods = Neighborhood.all 
  end 

  #TODO: Make this more secure, more dry, and more Convention over Configuration
  def toggle_reminders
    set_user
    @user.subscribed_to_reminders = !@user.subscribed_to_reminders
    @user.save
    respond_to do |format|
      format.html { redirect_to(user_path(@user)) }
      format.js
    end
  end

  #TODO: Make this more secure, more dry, and more Convention over Configuration
  def toggle_updates
    set_user
    @user.subscribed_to_neighborhood_updates = !@user.subscribed_to_neighborhood_updates
    @user.save
    respond_to do |format|
      format.html { redirect_to(user_path(@user)) }
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


end