Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  get 'home/index'
  get 'how_to_use' => 'home#how_to_use'

  root to: "home#index"

  resources :rooms, only: [:index, :show]
  resources :organizations, only: [:index, :show] do
    member do
      get :join,   to: 'organizations#join'
    end
  end
  resources :users, only: [:show]

  namespace :settings do
    get '/profile'  => 'profile#show'
    put '/profile'  => 'profile#update'
    get '/account'  => 'account#show'
    patch '/account'  => 'account#update'
  end

  mount API::Root => '/api'
end
