class Admin::NeighborhoodsController < Admin::AdminController

  def index
    @neighborhoods = Neighborhood.all.order(:name)
  end 

end