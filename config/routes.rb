Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # Admin authentication routes
  get 'admin_login', to: 'admin_sessions#new'
  post 'admin_login', to: 'admin_sessions#create'
  delete 'admin_logout', to: 'admin_sessions#destroy'

  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  get 'signup', to: 'users#new', as: 'signup'
  post 'users', to: 'users#create'

  # Other routes
  root 'home#index'
  resources :products, only: [:index, :show]
  resources :cart, only: [:index]
  resource :account, only: [:show]
  resources :users, only: [:new, :create]
  namespace :admin do
    resources :products
  end
end
