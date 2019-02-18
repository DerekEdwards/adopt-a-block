class BlocksController < ApplicationController

  before_action :set_block, except: [:new, :create]
  before_action :ensure_access, only: [:unadopt]

  def show
    @new_cleaning = Cleaning.new
  end 

  def create
    @block = Block.new(block_params)
    @block.neighborhood = Neighborhood.find(params[:neighborhood_id])
    @block.polyline = converted_polyline
    @block.save
    redirect_to neighborhood_path @block.neighborhood
  end

  def new
    @block = Block.new
    @block.neighborhood = Neighborhood.find(params[:neighborhood_id])
  end

  def edit
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
    redirect_to block_path(@block)
  end

  def unadopt
    @block.unadopt
    redirect_to block_path(@block)
  end

  def adopt
    @block.adopt current_user
    redirect_to block_path(@block)
  end

  private

  def ensure_access
    unless current_user and @block.user == current_user
      redirect_to root_url
      return
    end
  end

  def set_block
    @block = Block.find(params[:id])
  end

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