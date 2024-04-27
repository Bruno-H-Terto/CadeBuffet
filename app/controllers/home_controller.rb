class HomeController < ApplicationController
  before_action :authenticate_owner
  def index
  end

  def list

  end

  private

  def authenticate_owner
    @buffet = Buffet.find_by(owner: current_buffets_owner)
    if buffets_owner_signed_in?
      flash.notice = 'Acesso indisponível.'
      redirect_to buffet_path(@buffet)
    end 
  end
end