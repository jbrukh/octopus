Ruby::Application.routes.draw do

  # api routes
  namespace :api do
    resource :theories
  end

  # websites routes
  root to: 'welcome#index'
end
