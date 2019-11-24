class EventsController < ApplicationController

  before_action :confirm_admin

  def new
    @event = Event.new
    @event.neighborhood = Neighborhood.find(params[:neighborhood_id])
  end
  
end