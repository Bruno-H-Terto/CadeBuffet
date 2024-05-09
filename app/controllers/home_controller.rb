class HomeController < ApplicationController
  before_action :authenticate_owner, only: %i[index]
  def index
  end

  def list
    @buffets = Buffet.order(brand_name: :asc).all
  end

  def show
    @buffet = Buffet.find(params[:id])
    @events = Event.where(buffet: @buffet)
  end

  def search
    @q = params[:query]
    @buffets = Buffet.order(brand_name: :asc).where('brand_name like ? OR city like ? OR description like ?', "%#{@q}%",
                "%#{@q}%", "%#{@q}%")
  end

  def new_order
    @events = Event.order(name: :asc).all
  end

  private

  def authenticate_owner
    @buffet = Buffet.find_by(owner: current_buffets_owner)
    if buffets_owner_signed_in?
      redirect_to buffet_path(@buffet)
    end 
  end
end