Rails.application.routes.draw do

  root to: 'home#index'
  get 'list', to: 'home#list', as: 'listing'
  get 'search', to: 'home#search', as: 'search'
  resources :home, only: %i[show]

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
 

  resources :events, only: %i[new create] do
    resource :price_events, only: %i[new create]
  end
  resources :events, only: %i[show edit update]
  
end
