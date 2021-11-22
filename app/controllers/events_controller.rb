class EventsController < ApplicationController
  def index
    #@events = Event.all
    @user = User.find(params[:user_id])
    @events = @user.events
  end

  def new
    @event = Event.new
  end

  def create
    Event.create(event_parameter.merge({user_id: current_user.id}))
    redirect_to user_events_path
  end

  private

  def event_parameter
    params.require(:event).permit(:user_id, :title, :content, :start_time)
  end

end
