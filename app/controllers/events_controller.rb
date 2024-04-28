class EventsController < ApplicationController
  before_action :authenticate_buffets_owner!
  def show
    @event = Event.find(params[:id])
    @price = PriceEvent.find(@event.price_events)
  end

  def new
    @event = Event.new
    @price = PriceEvent.new
    @buffet = Buffet.find_by(owner: current_buffets_owner)
  end



  def create
    @buffet = Buffet.find_by(owner: current_buffets_owner)
    @event = Event.new(event_params)
    @event.owner = @buffet.owner
    @event.buffet = @buffet
    
    @price = PriceEvent.new(price_event_params)  # Uso correto do método
    @price.event = @event  # Associa ao evento

    if @event.valid? && @price.valid?
      @event.save!
      @price.save!  # Salva o PriceEvent associado ao evento
      flash.notice = 'Evento registrado com sucesso!'
      redirect_to buffet_path(@buffet)
    else
      flash.notice = 'Não foi possível cadastrar seu Evento.'
      render 'new'
    end
  end


  def edit
    @event = Event.find(params[:id])
    @price = PriceEvent.find_by(event: @event)
    @buffet = Buffet.find(@event.buffet_id)
  end
  
  def update
    @event = Event.find(params[:id])
    @price = PriceEvent.find_by(event: @event)

    if @event.update(event_params) && @price.update(price_event_params)
      flash.notice = 'Evento atualizado com sucesso!'
      redirect_to buffet_path(@buffet)
    else
      flash.notice = 'Não foi possível atualizar seu Evento.'
      render 'edit'
    end

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
        :min_price_working_day,
        :min_price_weekend,
        :additional_price_for_person_working_day,
        :additional_price_for_person_weekend,
        :extra_hour_working_day,
        :extra_hour_weekend,
        :_destroy
      ]
    )[:price_event] 
  end

end