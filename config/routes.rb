Rails.application.routes.draw do

  root to: "main_page#index"

  resources :categories do
    resources :products
  end

  resources :reviews
  resources :users
  resources :orders

  resources :billing_data
  resources :product


  # get 'items/index'
  # get 'items/show'
  # get 'items/edit'
  # get 'items/update'
  # get 'items/new'
  # get 'items/create'
  # get 'items/destroy'

  # get 'main_page/index'
  # get 'categories/index'
  # get 'categories/show'
  # get 'categories/edit'
  # get 'categories/update'
  # get 'categories/new'
  # get 'categories/create'
  # get 'categories/destroy'

  # get 'reviews/index'
  # get 'reviews/show'
  # get 'reviews/edit'
  # get 'reviews/update'
  # get 'reviews/new'
  # get 'reviews/create'
  # get 'reviews/destroy'

  #  get 'billing_data/index'
  #  get 'billing_data/show'
  #  get 'billing_data/edit'
  #  get 'billing_data/update'
  #  get 'billing_data/new'
  #  get 'billing_data/create'
  # get 'billing_data/destroy'

  # get 'entries/index'
  # get 'entries/show'
  # get 'entries/edit'
  # get 'entries/update'
  # get 'entries/new'
  # get 'entries/create'
  # get 'entries/destroy'

  # get 'orders/index'
  # get 'orders/show'
  # get 'orders/edit'
  # get 'orders/update'
  # get 'orders/new'
  # get 'orders/create'
  # get 'orders/destroy'

  # get 'products/index'
  # get 'products/show'
  # get 'products/edit'
  # get 'products/update'
  # get 'products/new'
  # get 'products/create'
  # get 'products/destroy'

  # get 'product/index'
  # get 'product/show'
  # get 'product/edit'
  # get 'product/update'
  # get 'product/new'
  # get 'product/create'
  # get 'product/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
