class Admin::BlocksController < ApplicationController

  def show
    @block = Block.find(params[:id])
    @new_cleaning = Cleaning.new
  end 

end