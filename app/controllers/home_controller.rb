class HomeController < ApplicationController
  before_action :authenticate_owner, only: %i[index]
  before_action :authenticate_client!, only: %i[new_order]
  def index
  end

  def list
    buffets = Buffet.order(brand_name: :asc).all
    @ordened_buffets = buffets.group_by { |first_char| first_char.brand_name[0].upcase }
    @ordened_buffets
  end

  def show
    @buffet = Buffet.find(params[:id])
    @events = Event.where(buffet: @buffet)
  end

  def search
    @q = params[:query]
    buffets = Buffet.order(brand_name: :asc).where('brand_name like ? OR city like ? OR description like ?', "%#{@q}%",
                "%#{@q}%", "%#{@q}%")

    @ordened_buffets = buffets.group_by { |first_char| first_char.brand_name[0].upcase }
    @ordened_buffets
  end

  def new_order
    @events = Event.order(name: :asc).all
  end

  private

  def authenticate_owner
    @buffet = Buffet.find_by(owner: current_my_company_owner)
    redirect_to buffet_path(@buffet) if my_company_owner_signed_in?
  end
end