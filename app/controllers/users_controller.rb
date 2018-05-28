class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @neighborhoods = Neighborhood.all 
  end 

end