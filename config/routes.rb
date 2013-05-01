Ruby::Application.routes.draw do

  # api routes
  namespace :api do
    resources :theories
    resources :videos
    resources :recordings

    devise_for :users
  end

  # websites routes
  root to: 'welcome#index'
end
