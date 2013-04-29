Ruby::Application.routes.draw do

  # api routes
  namespace :api do
    resources :theories
  end

  # websites routes
  root to: 'welcome#index'
end
