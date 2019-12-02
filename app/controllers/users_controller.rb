class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @neighborhoods = Neighborhood.all 
  end 

  #TODO: Make this more secure, more dry, and more Convention over Configuration
  def toggle_reminders
    @user = User.find(params[:id])
    @user.subscribed_to_reminders = !@user.subscribed_to_reminders
    @user.save
    respond_to do |format|
      format.html { redirect_to(user_path(@user)) }
      format.js
    end
  end

    #TODO: Make this more secure, more dry, and more Convention over Configuration
  def toggle_updates
    @user = User.find(params[:id])
    @user.subscribed_to_neighborhood_updates = !@user.subscribed_to_neighborhood_updates
    @user.save
    respond_to do |format|
      format.html { redirect_to(user_path(@user)) }
      format.js
    end
  end

end