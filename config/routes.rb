Ruby::Application.routes.draw do

  devise_for :users

  # api routes
  namespace :api do
    resources :theories
    resources :videos
    resources :recordings
  end

  resources :octopus

  # websites routes
  root to: 'welcome#index'
end