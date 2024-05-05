class OrdersController < ApplicationController
  def index
    @client = current_client
    @orders = Order.where('client_id = ?', @client.id)
  end

  def new
    @event = Event.find(params[:home_id])
    @buffet = Buffet.find(@event.buffet_id)
    @order = Order.new
  end

  def create
    @event = Event.find(params[:home_id])
    @buffet = Buffet.find(@event.buffet_id)
    @client = current_client
    @order = Order.new(order_params)
    @order.client = @client
    @order.buffet = @buffet
    @order.event = @event

    unless @event.fixed_location
      @order.address = order_location
    else
      @order.address = @buffet.full_address
    end

    return redirect_to root_path, notice: 'Pedido realizado com sucesso' if @order.save
    flash.notice = 'Não foi possível realizar o pedido'
    render 'new'
  end

  private

  def order_params
    params.require(:order).permit(:estimated_date, :estimated_people, :details)
  end

  def order_location
    params.require(:order).permit(:address)
  end
end