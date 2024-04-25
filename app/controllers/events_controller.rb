
class EventsController < ApplicationController
  before_action :authenticate_buffets_owner!
  def show
    @event = Event.find(params[:buffet_id])

  end

  def new
    @event = Event.new
  end



  def create
    @buffet = Buffet.find_by(owner: current_buffets_owner)
    @event = Event.new(event_params)
    @event.owner = @buffet.owner
    @event.buffet = @buffet

    if @event.save
      @event.price_events.create(price_event_params.values)
      flash.notice = 'Evento registrado com sucesso!'

      redirect_to buffet_path(@buffet)
    else
      flash.notice = 'Não foi possível concluir está operação.'
      render 'new'
    end
    
  end

  def edit
    @event = Event.find(params[:buffet_id])
    @buffet = Buffet.find(@event.buffet_id)
  end
  
  def update
    @event = Event.find(params[:buffet_id])
    @buffet = Buffet.find(@event.buffet_id)
    
    if @event.update(event_params)
      redirect_to buffets_buffet_path(@buffet)
      return flash.notice = 'Evento registrado com sucesso!'
    end
    
    flash.notice = 'Não foi possível concluir está operação.'
    render 'edit'

  end

  private
    def event_params
      params.require(:event).permit(
    :name,
    :min_quantity_people,
    :max_quantity_people,
    :duration_in_minutes,
    :alcoholic_drink,
    :self_decoration,
    :parking,
    :valet,
    :fixed_location,
    :description,
    :menu
    )
  end
  def price_event_params
    params.require(:event).permit(
      price_event: [
        :id,
        :min_price_working_day, :min_price_weekend,
        :additional_price_for_person_working_day,
        :additional_price_for_person_weekend,
        :extra_hour_working_day,
        :extra_hour_weekend,
        :_destroy
      ]
    )
  end

end