Rails.application.routes.draw do



  root to: 'products#index'

  resources :products, :except => [:delete]
  resources :merchants, :except => [:delete]
  resources :orders, :except => [:delete]
  resources :reviews, :only => [:create]
  get "/reviews/:product_id/new", to: "reviews#new", as: "new_review"
end
