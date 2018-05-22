class Admin::BlocksController < ApplicationController

  def show
    @block = Block.find(params[:id])
    @new_cleaning = Cleaning.new
  end 

  def create
    @block = Block.new(block_params)
    @block.neighborhood = Neighborhood.find(params[:neighborhood_id])
    @block.save
    redirect_to admin_neighborhood_path @block.neighborhood
  end

  def new
    @block = Block.new
    @block.neighborhood = Neighborhood.find(params[:neighborhood_id])
  end

  private

  def block_params
    params.require(:block).permit(:name, :description, :polyline)
  end

end