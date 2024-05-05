class BuffetController < ApplicationController

  before_action :authenticate_buffets_owner!
  before_action :redirect_owner, except: [:create]

  def show
    @buffet = Buffet.find(params[:id])
    @events = Event.where(buffet: @buffet)
  end

  def new
    if Buffet.find_by(owner: current_buffets_owner).nil?
      @buffet = Buffet.new 
    else
      flash.alert = 'Buffet já cadastrado' if request.path == new_buffet_path
      redirect_to buffet_path(Buffet.find_by(owner: current_buffets_owner))
    end
  end

  def create
    owner = current_buffets_owner

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

  def orders
    @buffet = Buffet.find(params[:buffet_id])
    @orders = Order.where('status = ? AND buffet_id = ?', 0, @buffet.id).order(estimated_date: :asc)
    @other_orders = Order.where('NOT status = ? AND buffet_id = ?', 0, @buffet.id).order(estimated_date: :asc)
  end

  def order_view
    @order = Order.find(params[:id])
    @order_count = Order.where('estimated_date = ? AND buffet_id = ? AND NOT status = ?', @order.estimated_date, @order.buffet_id,
                                3).where('estimated_date >= ?', Date.today)

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

end
