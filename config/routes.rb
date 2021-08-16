Rails.application.routes.draw do
  root 'frontend#bank'

  namespace :api do
    resources :links, only: [:create]
    resources :accounts, only: [:index] do
      resources :movements, only: [:index]
    end
  end
end
