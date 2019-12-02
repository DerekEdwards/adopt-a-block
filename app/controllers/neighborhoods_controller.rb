class NeighborhoodsController < ApplicationController

  before_action :confirm_admin, except: [:show, :index]

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @blocks =  @neighborhood.blocks
    @upcoming_events = @neighborhood.events.future.order(:canceled).order(:event_date).limit(3)
    @map_hash = @neighborhood.map_hash
  end 

  def index
    @neighborhoods = Neighborhood.published.order(:name)
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.save
    redirect_to neighborhood_path @neighborhood
  end

  def edit
    @neighborhood = Neighborhood.find(params[:id])
  end

  def update
    @neighborhood = Neighborhood.find(params[:id])
    @neighborhood.update(neighborhood_params)
    @neighborhood.save
    redirect_to neighborhood_path @neighborhood
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :description, :message, :photo, :lat, :lng, :zoom, :published)
  end

end