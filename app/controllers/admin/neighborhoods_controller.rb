class Admin::NeighborhoodsController < ApplicationController

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @blocks =  @neighborhood.blocks
    @map_hash = @neighborhood.map_hash
  end 

  def index
    @neighborhoods = Neighborhood.all.order(:name)
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.save
    redirect_to admin_neighborhood_path @neighborhood
  end

  def edit
    @neighborhood = Neighborhood.find(params[:id])
  end

  def update
    @neighborhood = Neighborhood.find(params[:id])
    @neighborhood.update(neighborhood_params)
    @neighborhood.save
    redirect_to admin_neighborhood_path @neighborhood
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :description, :message, :photo)
  end

end