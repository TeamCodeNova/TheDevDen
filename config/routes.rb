# config/routes.rb
Rails.application.routes.draw do
  get 'about/show'
  get 'about/update'
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
  resource :about, only: [:show, :edit, :update], controller: 'about'
  # Admin namespace
  namespace :admin do
    resources :products
    get 'dashboard', to: 'dashboard#index'
    get 'about/edit', to: 'about#edit', as: 'edit_about'
    put 'about', to: 'about#update'
  end
end
