Rails.application.routes.draw do

  resources :products, :except => [:delete]

end
