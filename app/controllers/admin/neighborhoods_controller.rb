class Admin::NeighborhoodsController < ApplicationController

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @blocks =  @neighborhood.blocks.pluck(:polyline)
  end 

end