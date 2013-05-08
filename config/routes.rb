Ruby::Application.routes.draw do

  devise_for :users

  # api routes
  namespace :api do
    resources :experiments

    resources :recordings do
      resources :results
    end

    # media
    resources :videos
    resources :slideshows
  end

  resources :octopus

  # websites routes
  root to: 'welcome#index'
end