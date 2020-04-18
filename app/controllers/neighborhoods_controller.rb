class NeighborhoodsController < ApplicationController

  before_action :confirm_admin, except: [:show, :index, :follow, :unfollow]

  def show
    set_neighborhood
    @blocks =  @neighborhood.blocks
    @upcoming_events = @neighborhood.events.future.order(:canceled).order(:event_date).limit(3)
    @map_hash = @neighborhood.map_hash
    @new_comment = Comment.new
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
    set_neighborhood
  end

  def update
    set_neighborhood
    @neighborhood.update(neighborhood_params)
    @neighborhood.save
    redirect_to neighborhood_path @neighborhood
  end

  def follow
    set_neighborhood
    @neighborhood.add_follower current_user
    redirect_to neighborhood_path @neighborhood
  end

  def unfollow
    set_neighborhood
    @neighborhood.remove_follower current_user
    redirect_to neighborhood_path @neighborhood
  end

  private 

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :description, :message, :photo, :lat, :lng, :zoom, :published)
  end

  def set_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end

end