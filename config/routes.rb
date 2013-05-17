require 'sidekiq/web'

Ruby::Application.routes.draw do

  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  # api routes
  namespace :api do
    resources :experiments

    resources :recordings do
      resource :results
      resource :taggings
    end

    # media
    resources :videos
    resources :slideshows
    resources :events
  end

  resources :octopus

  # websites routes
  root to: 'welcome#index'
end