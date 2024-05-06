class OrdersController < ApplicationController
  before_action :authenticate_client!
  def index
    @client = current_client
    @orders_waiting_confirmation = Order.where('client_id = ? AND status = ?', @client.id, 1)
    @other_orders = Order.where('client_id = ? AND NOT status = ?', @client.id, 1)
  end

  def index_confirmed
    @client = current_client
    @orders = Order.where('client_id = ? AND status = ?', @client.id, '2').order(estimated_date: :asc)
    return redirect_to root_path, notice: 'Acesso indisponível' if @orders.nil?
  end

  def show
    @order = Order.find(params[:id])
    return redirect_to root_path, notice: 'Acesso indisponível' if @order.status != 'confirmed_for_buffet' 
    @buffet = @order.buffet
    @price_order = PriceOrder.find_by(order: @order)
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

  def confirm_event
    return redirect_to root_path unless is_client?
    @order = Order.find(params[:id])
    @price_order = PriceOrder.find_by(order: @order)
    @buffet = @order.buffet
    date_time = @price_order.deadline >= Date.today
    if params[:status] == '2' && date_time
      @order.confirmed!
      return redirect_to root_path, notice: 'Evento confirmado com sucesso'
    end
    @order.canceled!
    redirect_to order_path(@order)
    date_time ? flash.notice = 'Prazo para confirmação esgotado' : flash.notice = 'Evento cancelado'
  end

  private

  def order_params
    params.require(:order).permit(:estimated_date, :estimated_people, :details)
  end

  def order_location
    params.require(:order).permit(:address)
  end

  def is_client?
    @order = Order.find(params[:id])
    current_client == @order.client
  end
end