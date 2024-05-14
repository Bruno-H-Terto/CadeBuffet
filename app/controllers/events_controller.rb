class EventsController < ApplicationController
  before_action :authenticate_my_company_owner!
  def show
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_owner?
    @event = Event.find(params[:id])
    @price = PriceEvent.find(@event.price_events)
  end

  def new
    @event = Event.new
    @price = PriceEvent.new
    @buffet = Buffet.find_by(owner: current_my_company_owner)
  end



  def create
    @buffet = Buffet.find_by(owner: current_my_company_owner)
    @event = Event.new(event_params)
    @event.owner = @buffet.owner
    @event.buffet = @buffet
    
    @price = PriceEvent.new(price_event_params) 
    @price.event = @event

    if @event.valid? && @price.valid?
      @event.save!
      @price.save! 
      return redirect_to buffet_path(@buffet), notice: 'Evento registrado com sucesso!'
    end
      flash.notice = 'Não foi possível cadastrar seu Evento.'
      render 'new'
    
  end


  def edit
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_owner?
    @event = Event.find(params[:id])
    @price = PriceEvent.find_by(event: @event)
    @buffet = Buffet.find(@event.buffet_id)
  end
  
  def update
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_owner?
    @event = Event.find(params[:id])
    
    
    @price = PriceEvent.find_by(event: @event)

    if @event.update(event_params) && @price.update(price_event_params)
      flash.notice = 'Evento atualizado com sucesso!'
      return redirect_to buffet_path(@buffet)
    end
      flash.notice = 'Não foi possível atualizar seu Evento.'
      render 'edit'
    

  end

  def historic_orders
    @event = Event.find(params[:event_id])
    @historic = Event.find(params[:event_id]).orders
    return redirect_to root_path, alert: 'Acesso não autorizado' unless  Event.find(params[:event_id]).owner == current_my_company_owner
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

  def is_owner?
    begin
      @event = Event.find(params[:id])
      @event.owner == current_my_company_owner
    rescue
      false
    end
  end

end