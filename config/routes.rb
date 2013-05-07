Ruby::Application.routes.draw do

  devise_for :users

  # api routes
  namespace :api do
    resources :theories
    resources :recordings

    # media
    resources :videos
    resources :slideshows
  end

  resources :octopus

  # websites routes
  root to: 'welcome#index'
end