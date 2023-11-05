Rails.application.routes.draw do
  # Admin authentication routes
  get 'admin_login', to: 'admin_sessions#new'
  post 'admin_login', to: 'admin_sessions#create'
  delete 'admin_logout', to: 'admin_sessions#destroy'

  # Other routes
  root 'home#index'
  resources :products, only: [:index, :show]
  resources :cart, only: [:index]
  resource :account, only: [:show]
  namespace :admin do
    resources :products
  end
end
