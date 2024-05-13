Rails.application.routes.draw do
  
  root to: 'home#index'
 

  resources :home, only: %i[show] do 
    resources :orders, only: %i[new create]
    get 'list', on: :collection
    get 'search', on: :collection
    get 'new_order', on: :collection
  end
  
  resources :orders, only: %i[index show] do
    get 'confirmed', on: :collection
    post 'confirm_event/:status', to: 'orders#confirm_event', as: 'confirm_event'
  end


  namespace :my_company do
    devise_for :owners, controllers: {
      sessions: 'my_company/owners/sessions',
      confirmations: 'my_company/owners/confirmations',
      omniauth: 'my_company/owners/omniauth',
      passwords: 'my_company/owners/passwords',
      registrations: 'my_company/owners/registrations',
      unlocks: 'my_company/owners/unlocks'
    }
  end

  resources :buffet, only: %i[show new create edit update] do
    get 'orders', to: 'buffet#orders', as: 'my_orders'
  end
  get 'order_view/:id', to: 'buffet#order_view', as: 'order_view' 
  post 'confirm_order/:id/:status', to: 'buffet#confirm_order', as: 'confirm_order'

  get 'new_price_order/:id', to: 'price_orders#new', as: 'new_price_order'
  post 'price_orders/:id', to: 'price_orders#create', as: 'price_orders'

  resources :events, only: %i[new create show edit update] do
    resources :price_events, only: %i[new create]
    get 'historic_orders', to: 'events#historic_orders', as: 'historic_orders'
  end

  devise_for :clients
  



  namespace :api do
    namespace :v1 do
      resources :buffets, only: %i[index show] do
        resources :events, only: %i[index]
      end
    end
  end
end
