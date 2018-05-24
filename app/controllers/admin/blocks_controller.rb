class Admin::BlocksController < ApplicationController

  def show
    @block = Block.find(params[:id])
    @new_cleaning = Cleaning.new
  end 

  def create
    puts params[:polyline]
    @block = Block.new(block_params)
    @block.neighborhood = Neighborhood.find(params[:neighborhood_id])
    @block.polyline = converted_polyline
    @block.save
    redirect_to admin_neighborhood_path @block.neighborhood
  end

  def new
    @block = Block.new
    @block.neighborhood = Neighborhood.find(params[:neighborhood_id])
  end

  def edit
    @block = Block.find(params[:id])
  end

  def update
    @block = Block.find(params[:id])
    @block.name = block_params["name"]
    @block.description = block_params["description"]
    formatted_polyline = converted_polyline
    unless formatted_polyline.first[:lat] == 0
      @block.polyline = formatted_polyline
    end
    @block.save
    redirect_to admin_neighborhood_path @block.neighborhood
  end


  private

  def block_params
    params.require(:block).permit(:name, :description, :polyline)
  end

  def converted_polyline
    formatted_polyline = []
    block_params["polyline"].gsub('(','').gsub(')','').gsub(' ','').split(',').in_groups_of(2) do |latlng|
      formatted_polyline << {lat: latlng.first.to_f, lng: latlng.last.to_f}
    end
    formatted_polyline
  end

end