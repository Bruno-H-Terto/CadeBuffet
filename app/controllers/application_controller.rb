class ApplicationController < ActionController::Base
  before_action :redirect_owner_to_home
  before_action :redirect_owner
  before_action :redirect_client
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  


  protected
    def redirect_owner_to_home

    current_path = request.path
    

    if my_company_owner_signed_in?
      @buffet = Buffet.find_by(owner: current_my_company_owner)
    

      if @buffet.nil? && current_path != new_buffet_path
        flash.alert = 'Registre o Buffet para prosseguir!'
        return redirect_to new_buffet_path
      end
    end


  end

  def redirect_client
    current_path = request.path
    
    
    if client_signed_in? && (current_path == new_my_company_owner_session_path || current_path == my_company_owner_session_path || current_path == new_my_company_owner_registration_path)
      flash.notice = 'Usuário não autorizado. Clique em sair e acesse a página com o login Proprietário.'
      redirect_to root_path
    end
  end

  def redirect_owner
    current_path = request.path
    
    
    if my_company_owner_signed_in? && (current_path == new_client_session_path || current_path == client_session_path || current_path == new_client_registration_path)
      flash.notice = 'Usuário não autorizado. Clique em sair e acesse a página com acesso de Cliente.'
      redirect_to root_path
    end
  end

  def record_not_found
    redirect_to root_path, notice: 'Requisição inválida'
  end
end
