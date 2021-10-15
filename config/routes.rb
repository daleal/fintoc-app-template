Rails.application.routes.draw do
  root 'frontend#main'

  namespace :api do
    resources :links, only: [:create]
  end
end
