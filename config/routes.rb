Rails.application.routes.draw do
  root to: 'products#index'

  resources :products, :except => [:delete]
  resources :merchants, :except => [:delete]
  get 'orders/cart', to: 'orders#show_cart', as: 'show_cart'
  patch 'orders/:id/quantity/:product_id', to: 'orders#update_quantity', as: 'update_quantity'
  # if users go back from their cart to an updated quantity page, redirect to show cart
  get 'order/:id/thank-you', to: 'orders#confirmation', as: 'order_confirmation'
  get 'orders/:id/quantity/:product_id', to: 'orders#show_cart', as: 'show_cart_redirect'
  delete 'orders/:id/:product_id', to: 'orders#remove_from_cart', as: 'remove_from_cart'
  patch '/orders/:id/add/:product_id', to: 'orders#add_item', as: 'add_order_item'
  resources :orders, :except => [:delete]
  get "/reviews/:product_id/new", to: "reviews#new", as: "new_review"
  resources :reviews, :except => [:delete]
  get '/checkout', to: 'orders#checkout_form', as: 'checkout_form'
  patch '/checkout', to: 'orders#checkout', as: 'checkout'
  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
  get 'sessions/create'
  get 'sessions/index'
  post '/logout', to: 'sessions#logout', as: 'logout'
end
