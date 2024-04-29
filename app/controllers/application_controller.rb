class ApplicationController < ActionController::Base
  before_action :redirect_owner


  protected
  def redirect_owner

    current_path = request.path
    

    if buffets_owner_signed_in?

      @buffet = Buffet.find_by(owner: current_buffets_owner)
    

      if @buffet.nil? && current_path != new_buffet_path
        flash.alert = 'Registre o Buffet para prosseguir!'
        return redirect_to new_buffet_path
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :register_number])
    end

  end
end
