Rails.application.routes.draw do
  
  
  get '/', to: 'home#dashboard', as: 'dashboard'
  namespace :users do
    devise_for :users
    root to: 'user#index'
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
    root to: 'owner#index'
  end

end
