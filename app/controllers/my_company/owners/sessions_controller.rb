# frozen_string_literal: true
module MyCompany
  class Owners::SessionsController < Devise::SessionsController
    before_action :redirect_owner_to_home, except: [:destroy]
  # before_action :configure_sign_in_params, only: [:create]

    def after_sign_in_path_for(resource)
      new_buffet_path
    end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  end



end