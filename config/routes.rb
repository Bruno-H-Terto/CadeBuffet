Rails.application.routes.draw do
  
  root to: 'home#index'
  get 'list', to: 'home#list', as: 'listing'
  get 'search', to: 'home#search', as: 'search'

  resources :home, only: %i[show] do 
    resources :orders, only: %i[new create]
  end

  resources :orders, only: %i[index show]
  post 'confirm_event/:id/:status', to: 'orders#confirm_event', as: 'confirm_event'
  get 'confirmed_orders', to: 'orders#index_confirmed', as: 'confirmed_orders'

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
  post 'confirm_order/:id/:status', to: 'buffet#confirm_order', as: 'confirm_order'
  get 'new_price_order/:id', to: 'price_orders#new', as: 'new_price_order'
  post 'price_orders/:id', to: 'price_orders#create', as: 'price_orders'

  resources :events, only: %i[new create] do
    resource :price_events, only: %i[new create]
  end

  resources :events, only: %i[show edit update]

  devise_for :clients
  
end
