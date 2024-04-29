class ApplicationController < ActionController::Base
  before_action :redirect_owner
  before_action :redirect_client
  before_action :configure_permitted_parameters, if: :devise_controller?
  


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

  def redirect_client
    current_path = request.path
    
    
    if client_signed_in? && (current_path == new_buffets_owner_session_path || current_path == buffets_owner_session_path || current_path == new_buffets_owner_registration_path)
      flash.notice = 'Usuário não autorizado. Clique em sair e acesse a página com o login Proprietário.'
      redirect_to root_path
    end
  end
end
