Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get 'store/index'
  root 'store#index', as: 'store'

  resources :products
end
