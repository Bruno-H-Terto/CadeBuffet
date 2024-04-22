class ApplicationController < ActionController::Base
  before_action :redirect_owner

  protected
    def redirect_owner
      current_path = request.path
      if buffets_owner_signed_in? && Buffet.find_by(owner: current_buffets_owner).nil? && current_path != new_buffets_buffet_path
        flash.alert = 'Registre o Buffet para prosseguir!'
        return redirect_to new_buffets_buffet_path 
      end

    end

end
