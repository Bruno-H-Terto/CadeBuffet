class OrdersController < ApplicationController
  before_action :authenticate_client!
  def index
    @client = current_client
    @orders_waiting_confirmation = Order.confirmed_for_buffet.joins(:price_order).where('client_id = ? AND deadline >= ?', @client.id, Date.today)
    @orders_expired = Order.confirmed_for_buffet.joins(:price_order).where('client_id = ? AND deadline < ?', @client.id, Date.today)
    .update_all(status: 3) 
    @other_orders = Order.not_confirmed.not_confirmed_for_buffet.where('client_id = ?', @client.id)
  end

  def confirmed
    @client = current_client
    @orders_confirmed = Order.confirmed.where('client_id = ?', @client.id).order(estimated_date: :asc)
    return redirect_to root_path, notice: 'Acesso indisponível' if @orders_confirmed.nil?
  end

  def show
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_client?
    @order = Order.find(params[:id])
    return redirect_to root_path, notice: 'Acesso indisponível' if @order.status != 'confirmed_for_buffet' 
    @buffet = @order.buffet
    @price_order = PriceOrder.find_by(order: @order)
  end

  def new
    how_many_orders_are_permited?
    @event = Event.find(params[:home_id])
    @buffet = Buffet.find(@event.buffet_id)
    @order = Order.new
  end

  def create
    how_many_orders_are_permited?
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
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_client?
    result= params_confirm
    @order = Order.find(result[:order_id])
    @price_order = PriceOrder.find_by(order: @order)
    @buffet = @order.buffet
    expired_date = (@price_order.deadline >= Date.today)

    case result[:status]
    when 'confirmed' 
      if expired_date
        @order.confirmed!
        return redirect_to root_path, notice: 'Evento confirmado com sucesso'
      end
    when 'canceled'
      @order.canceled!
      return redirect_to orders_path, notice: 'Evento cancelado'
    else
      return redirect_to orders_path, notice: 'Requisição inválida'
    end


    unless expired_date 
      @order.canceled!
      redirect_to orders_path, notice: 'Prazo para confirmação esgotado'
    end
  end

  private

  def order_params
    params.require(:order).permit(:estimated_date, :estimated_people, :details)
  end

  def order_location
    params.require(:order).permit(:address)
  end

  def is_client?
    begin
      @order = Order.find(params[:id])
    rescue
      @order = Order.find(params[:order_id])
    end
    current_client == @order.client
  end

  def params_confirm
    params.permit(:order_id, :status)
  end

  def how_many_orders_are_permited?
    @event = Event.find(params[:home_id])
    @buffet = Buffet.find(@event.buffet_id)
    client = current_client
    if Order.waiting_review.where('client_id = ? AND buffet_id = ?', client.id, @buffet.id).present?
      return redirect_to root_path, notice: 'Não é permitido o registro simultãneo de dois ou mais pedidos para o mesmo Buffet'
    end
    
  end
end