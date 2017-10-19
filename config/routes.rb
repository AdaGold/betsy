Rails.application.routes.draw do



  get 'sessions/create'

  get 'sessions/index'

  root to: 'products#index'

  resources :products, :except => [:delete]
  resources :merchants, :except => [:delete]
  resources :orders, :except => [:delete]
  resources :reviews, :except => [:delete]

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
end
