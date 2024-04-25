class ApplicationController < ActionController::Base
  before_action :redirect_owner


  protected
  def redirect_owner
    # Pega o caminho atual para comparar com os alvos de redirecionamento
    current_path = request.path
    
    # Verifica se o proprietário de buffet está logado
    if buffets_owner_signed_in?
      # Verifica se o proprietário tem um buffet
      @buffet = Buffet.find_by(owner: current_buffets_owner)
    
    # Se o buffet não existe e não está na página de criação de buffet, redireciona
      if @buffet.nil? && current_path != new_buffet_path
        flash.alert = 'Registre o Buffet para prosseguir!'
        return redirect_to new_buffet_path
      end
    end
  end
end
