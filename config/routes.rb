Rails.application.routes.draw do
  root 'home#index'
  resources :products, only: [:index, :show]
  resources :cart, only: [:index]
  resource :account, only: [:show]
  namespace :admin do
    resources :products
  end
end
