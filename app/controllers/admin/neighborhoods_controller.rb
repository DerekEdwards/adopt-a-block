class Admin::NeighborhoodsController < ApplicationController

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @blocks =  @neighborhood.blocks
    @map_hash = @neighborhood.map_hash
  end 

end