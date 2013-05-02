Ruby::Application.routes.draw do

  scope '/api' do
    devise_for :users, :controllers => {
      :registrations => "api/registrations" 
    }
  end

  # api routes
  namespace :api do
    resources :theories
    resources :videos
    resources :recordings
  end

  # websites routes
  root to: 'welcome#index'
end
