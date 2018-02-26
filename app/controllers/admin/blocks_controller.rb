class Admin::BlocksController < ApplicationController

  def show
    @block = Block.find(params[:id])
    @cleaning = Cleaning.new
  end 

end