class ApplicationController < ActionController::Base
  before_action :redirect_owner

  private
    def redirect_owner
      current_path = request.path
      if current_path != new_buffets_buffet_path && buffets_owner_signed_in? && Buffet.find_by(owner: current_buffets_owner).nil?
        flash.notice = 'Conclua o cadastro'
        return redirect_to new_buffets_buffet_path 
      end
    end
end
