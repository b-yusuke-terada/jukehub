Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'home/index'

  root to: "home#index"

  resources :rooms, only: [:index, :show]

  mount API::Root => '/api'
end
