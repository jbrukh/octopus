require 'sidekiq/web'

Ruby::Application.routes.draw do

  # register devise routes and add override for registrations
  devise_for :users, :controllers => { :registrations => "registrations" }
  ActiveAdmin.routes(self)

  # register sidekiq for running background tasks
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # marketing routes
  resources :features
  resources :connectors
  resources :contactus
  resources :faq

  # api routes
  namespace :api do
    resources :participants
    resources :experiments

    resources :recordings do
      resources :analysis
      resource  :taggings
    end

    resources :results
    resources :policies

    # media
    resources :videos
    resources :slideshows
    resources :events
  end

  resources :octopus

  # websites routes
  root to: 'welcome#index'
end