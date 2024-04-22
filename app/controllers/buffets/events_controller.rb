
class Buffets::EventsController < ApplicationController

  def new
    @buffet = Buffet.find(params[:buffet_id])
    @event = Event.new
  end

  def show
    @event = Event.find(params[:buffet_id])

  end

  def create
    @buffet = Buffet.find(params[:buffet_id])
    @event = Event.new(event_params)
    @event.owner = @buffet.owner
    @event.buffet = @buffet

    if @event.save
      redirect_to new_buffets_price_event_path(@event.id)
      return flash.notice = 'Evento registrado com sucesso!'
    end
    
    flash.notice = 'Não foi possível concluir está operação.'
    render 'new'
    
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
      params.require(:event).permit(:name, :description, :min_quantity_people, :max_quantity_people, :duration_in_minutes, :menu,
                                    :alcoholic_drink, :self_decoration, :parking, :valet, :fixed_location)
    end

end