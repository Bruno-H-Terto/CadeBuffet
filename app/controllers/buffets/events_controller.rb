
class Buffets::EventsController < ApplicationController

  def create
    @buffet = Buffet.find(params[:buffet_id])
    @event = Event.new(event_params)
    @event.owner = @buffet.owner
    @event.buffet = @buffet

    if @event.save
      redirect_to buffets_buffet_path(@buffet)
      return flash.notice = 'Evento registrado com sucesso!'
    end
    
    flash.notice = 'Não foi possível concluir está operação.'
    redirect_to buffets_buffet_path(@buffet.id, event_params)
    
  end

  def edit
    redirect_to buffets_buffet_path(@buffet.id, event_params)
  end
  private
    def event_params
      params.require(:event).permit(:name, :description, :min_quantity_people, :max_quantity_people, :duration_in_minutes, :menu,
                                    :alcoholic_drink, :self_decoration, :parking, :valet, :fixed_location)
    end

end