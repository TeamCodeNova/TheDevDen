# config/routes.rb
Rails.application.routes.draw do
  # Admin authentication routes
  get 'admin_login', to: 'admin_sessions#new', as: 'admin_login'
  post 'admin_login', to: 'admin_sessions#create'
  delete 'admin_logout', to: 'admin_sessions#destroy', as: 'admin_logout'

  # User authentication routes
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'signup', to: 'users#new', as: 'signup'
  post 'users', to: 'users#create'

  # Other routes
  root 'home#index'
  resources :products, only: [:index, :show]
  resources :cart, only: [:index]
  resource :account, only: [:show]
  resources :users, only: [:new, :create]

  # Admin namespace
  namespace :admin do
    resources :products
  end
end
