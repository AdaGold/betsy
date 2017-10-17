Rails.application.routes.draw do
  root to: 'products#index'
  resources :products, :except => [:delete]

end
