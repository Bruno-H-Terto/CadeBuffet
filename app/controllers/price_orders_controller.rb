class PriceOrdersController < ApplicationController
  before_action :authenticate_buffets_owner!

  def new
    @price_order = PriceOrder.new
    @order = Order.find(params[:id])
    @event = @order.event
    @buffet = @event.buffet.payment_methods
    @price_event = PriceEvent.find_by(event: @event)

    normal_price(@order, @event, @price_event)
  end

  def create
    @price_order = PriceOrder.new(price_order_params)
    @order = Order.find(params[:id])
    @event = @order.event
    @buffet = @event.buffet.payment_methods
    @price_event = PriceEvent.find_by(event: @event)

    @price_order.initial_price = normal_price(@order, @event, @price_event)
    @price_order.payment_methods = payment_methods_price_order
    @price_order.owner = @event.owner
    @price_order.order = @order
    @price_order.final_price = @price_order.initial_price + @price_order.rate

    if @price_order.save
      return redirect_to order_view_path(@order), notice: 'Valor do pedido registrado com sucesso!'
    end
    flash.notice = 'Não foi possível salvar as alterações'
    render 'new'

  end


  private

  def normal_price(order, event, price_event)
    weekend = (0 == order.estimated_date.wday || 6 == order.estimated_date.wday)
    add_people = order.estimated_people - event.min_quantity_people if order.estimated_people > event.min_quantity_people

    @initial_price = 0
    if weekend 
      @initial_price = price_event.min_price_weekend.to_i + price_event.additional_price_for_person_weekend*add_people
    else
      @initial_price = price_event.min_price_working_day.to_i + price_event.additional_price_for_person_working_day*add_people
    end
  end

  def price_order_params
    params.require(:price_order).permit(:rate, :description_rate, :deadline)
  end

  def payment_methods_price_order
    methods = params.require(:price_order).permit(payment_methods: [])[:payment_methods]
    methods.join(', ') if methods.present?
  end
end