Rails.application.routes.draw do

  root to: 'home#index'

  namespace :casual_users do
    devise_for :users
  end

  namespace :buffets do
    devise_for :owners, controllers: {
      sessions: 'buffets/owners/sessions',
      confirmations: 'buffets/owners/confirmations',
      omniauth: 'buffets/owners/omniauth',
      passwords: 'buffets/owners/passwords',
      registrations: 'buffets/owners/registrations',
      unlocks: 'buffets/owners/unlocks'
    }
    resources :buffet, only: %i[show new create] do
      resource :events, only: %i[new create edit update show]
    end
    resources :price_event, only: %i[new create]
  end

end
