module Buffets
 class BuffetController < ApplicationController
    before_action :authenticate_buffets_owner!
    before_action :redirect_owner, except: [:create]

    def index
    end

    def show
    end

    def new
      @buffet = Buffet.new
    end

    def create
      owner = current_buffets_owner
      buffet_params = params.require(:buffet).permit(:brand_name, :corporate_name, :city, :state, 
                      :address, :register_number, :phone_number, :district, :zip_code, :payment_methods,
                      :description)

      @buffet = Buffet.new(buffet_params)
      @buffet.owner = owner
      
      if @buffet.save!
        flash.notice = "Buffet salvo com sucesso!"
        redirect_to buffets_buffet_index_path
      else
        flash.alert = 'Não foi possível concluir está operação.'
        render 'new'
      end
    end

  end
  
end