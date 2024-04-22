class Buffets::PriceEventController < ApplicationController
  def new
    @price_event = PriceEvent.new
    @event = Event.find(params[:format])
  end

  def create
    @event = Event.find(params[:format])
    @price_event = PriceEvent.new(price_event_params)
  end
end