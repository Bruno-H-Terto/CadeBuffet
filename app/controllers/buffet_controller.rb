class BuffetController < ApplicationController

  before_action :authenticate_my_company_owner!
  before_action :redirect_owner_to_home, except: [:create, :update]

  def show
    return redirect_to root_path, alert: 'Acesso não autorizado' unless permited_owner_edit?
    @buffet = Buffet.find(params[:id])
    @events = Event.where(buffet: @buffet)
  end

  def new
    if Buffet.find_by(owner: current_my_company_owner).nil?
      @buffet = Buffet.new 
    else
      flash.alert = 'Buffet já cadastrado' if request.path == new_buffet_path
      redirect_to buffet_path(Buffet.find_by(owner: current_my_company_owner))
    end
  end

  def create
    owner = current_my_company_owner

    @buffet = Buffet.new(buffet_params)
    @buffet.payment_methods = payment_methods_params
    @buffet.owner = owner
    
    if @buffet.save
      flash.notice = "Buffet salvo com sucesso!"
      redirect_to buffet_path(@buffet)
    else
      flash.alert = 'Não foi possível salvar seu Buffet.'
      render 'new'
    end
  end

  def edit
    return redirect_to root_path, alert: 'Acesso não autorizado' unless permited_owner_edit?
    @buffet = Buffet.find(params[:id])
  end

  def update
    return redirect_to root_path, alert: 'Acesso não autorizado' unless permited_owner_edit?
    @buffet = Buffet.find(params[:id])
    @buffet.payment_methods = payment_methods_params
    
    
  
    return redirect_to buffet_path(@buffet), notice: "Buffet atualizado com sucesso!" if @buffet.update(buffet_params)

    flash.alert = 'Não foi possível atualizar seu Buffet.'
    render 'edit'

  end

  def orders
    @buffet = Buffet.find(params[:buffet_id])
    return redirect_to root_path, alert: 'Acesso não autorizado' unless @buffet.owner == current_my_company_owner
    @orders_waiting_review = Order.waiting_review.where('buffet_id = ?', @buffet.id).order(estimated_date: :asc).group_by { |date| date.estimated_date }
    @other_orders = Order.not_waiting_review.where('buffet_id = ?', @buffet.id).order(estimated_date: :asc).group_by { |date| date.estimated_date }
  end

  def order_view
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_owner?
    @order = Order.find(params[:id])
    @buffet = @order.buffet
    @event = @order.event
    @price_event = PriceEvent.find_by(event: @event)
    @order_count = Order.not_canceled.where('estimated_date = ? AND buffet_id = ?', @order.estimated_date, @order.buffet_id
                                ).where('estimated_date >= ?', Date.today)

    @price_order = PriceOrder.find_by(order: @order) if @order.price_order.present?


  end

  def confirm_order
    result = params_confirm
    @order = Order.find(result[:id])
    @buffet = @order.buffet
    return redirect_to root_path, alert: 'Acesso não autorizado' unless is_owner?

    case result[:status]
    when 'confirmed' 
      @order.confirmed_for_buffet!
      redirect_to order_view_path(@order), notice: 'Pedido confirmado'
    when 'canceled'
      @order.canceled!
      redirect_to order_view_path(@order), notice: 'Pedido cancelado'
    else
      redirect_to orders_view_path, notice: 'Requisição inválida'
    end

  end

  private

  def buffet_params
    params.require(:buffet).permit(:brand_name, :corporate_name, :city, :state, 
    :address, :register_number, :phone_number, :district, :zip_code,
    :description)
  end

  def payment_methods_params
    methods = params.require(:buffet).permit(payment_methods: [])[:payment_methods]
    methods.join(', ') if methods.present?
  end

  def permited_owner_edit?
    begin
      @buffet = Buffet.find(params[:id])
      @buffet.owner == current_my_company_owner
    rescue
      false
    end
  end

  def is_owner?
    @order = Order.find(params[:id])
    @buffet = @order.buffet
    @buffet.owner == current_my_company_owner
  end

  def params_confirm
    params.permit(:id, :status)
  end
end
