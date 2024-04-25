Rails.application.routes.draw do

  root to: 'home#index'


  namespace :buffets do
    devise_for :owners, controllers: {
      sessions: 'buffets/owners/sessions',
      confirmations: 'buffets/owners/confirmations',
      omniauth: 'buffets/owners/omniauth',
      passwords: 'buffets/owners/passwords',
      registrations: 'buffets/owners/registrations',
      unlocks: 'buffets/owners/unlocks'
    }

  end
  resources :buffet, only: %i[show new create]
  resource :events, only: %i[new create] do
    resources :price_events, only: %i[new create]
  end
end
