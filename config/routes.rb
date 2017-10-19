Rails.application.routes.draw do



  get 'sessions/create'

  get 'sessions/index'

  root to: 'products#index'

  resources :products, :except => [:delete]
  resources :merchants, :except => [:delete]
  get 'orders/cart', to: 'orders#show_cart', as: 'show_cart'
  patch 'orders/:id/quantity/:product_id', to: 'orders#update_quantity', as: 'update_quantity'
  patch '/orders/:id/add/:product_id', to: 'orders#add_item', as: 'add_order_item'
  resources :orders, :except => [:delete]
  resources :reviews, :except => [:delete]
  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
end
