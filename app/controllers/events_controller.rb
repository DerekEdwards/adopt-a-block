class EventsController < ApplicationController

  before_action :confirm_admin

  def new
    @event = Event.new
    @event.neighborhood = Neighborhood.find(params[:neighborhood_id])
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.neighborhood = Neighborhood.find(params[:neighborhood_id])
    if @event.save
      if other_params[:send_emails] == "1"
        SendNewEventEmailsJob.perform_later @event
      end
      redirect_to neighborhood_path @event.neighborhood
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      if other_params[:send_emails] == "1"
        SendUpdatedEventEmailsJob.perform_later @event
      end
      redirect_to neighborhood_path @event.neighborhood
    end
  end

  private

  def other_params
    params.require(:other).permit(:send_emails)
  end

  def event_params
    params.require(:event).permit(:name, :location_description, :description, :event_date, :start_time, :end_time, :canceled)
  end
end