Rails.application.routes.draw do

  root to: 'products#index'

  resources :products, :except => [:delete]
  resources :merchants, :except => [:delete]
  resources :orders, :except => [:delete]

end
