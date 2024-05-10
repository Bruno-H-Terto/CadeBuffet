class PriceEventsController < ApplicationController
  before_action :authenticate_my_company_owner!
  def new
    @price_event = PriceEvent.new
    @event = Event.find(params[:format])
  end

  def create

    @event = Event.find(params[:format])
    @buffet = Buffet.find(@event.buffet_id)
    @price_event = PriceEvent.new(price_event_params)
    @price_event.event_id = @event.id

    redirect_to my_company_buffet_path(@buffet), flash.notice = 'Valores salvos com sucesso!' if @price_event.save

    flash.alert = 'Não foi possível registrar os valores para este evento'
  end

  private
    def price_event_params
      params.require(:price_event).permit(:min_price_working_day, :additional_price_for_person_working_day, :additional_price_for_person_weekend, :min_price_weekend,
                                    :extra_hour_weekend, :extra_hour_working_day )
    end

end