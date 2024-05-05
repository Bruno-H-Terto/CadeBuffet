Rails.application.routes.draw do
  
  root to: 'home#index'
  get 'list', to: 'home#list', as: 'listing'
  get 'search', to: 'home#search', as: 'search'

  resources :home, only: %i[show] do 
    resources :orders, only: %i[new create]
  end

  resources :orders, only: %i[index]

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

  resources :buffet, only: %i[show new create] do
    get 'orders', to: 'buffet#orders', as: 'my_orders'
  end

  get 'order_view/:id', to: 'buffet#order_view', as: 'order_view'
 
  resources :events, only: %i[new create] do
    resource :price_events, only: %i[new create]
  end

  resources :events, only: %i[show edit update]

  devise_for :clients
  
end
