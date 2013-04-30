Ruby::Application.routes.draw do

  # api routes
  namespace :api do
    resources :theories
    resources :videos
  end

  # websites routes
  root to: 'welcome#index'
end
