Rails.application.routes.draw do
  root 'movie_center#index'
 
  concern :endpoints do
    resources :movies, only: [:index]
    resources :music, only: [:index]
    resources :theater, only: [:index]
  end

  # V1
  namespace :api do
    concerns :endpoints
  end

  resources :movie_center, only: [:index]
  resources :tickantel, only: [:index]
end
