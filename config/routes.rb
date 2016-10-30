Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  get 'home/index'

  root to: "home#index"

  resources :rooms, only: [:index, :show]
  resources :organizations, only: [:index, :show]
  resources :users, only: [:show]

  mount API::Root => '/api'
end
