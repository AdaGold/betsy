Rails.application.routes.draw do

  root to: 'products#index'

  resources :products, :except => [:delete]
  resources :merchants, :except => [:delete]
  resources :orders, :except => [:delete]
  resources :reviews, :except => [:delete]

  patch '/orders/:id/add/:product_id', to: 'orders#add_item', as: 'add_order_item'
  get 'orders/cart', to: 'orders#show_cart', as: 'show_cart'

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
  post '/logout', to: 'sessions#logout', as: 'logout'

end
