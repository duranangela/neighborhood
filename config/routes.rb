Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :neighborhoods, only: [:index]
      resources :projects, only: [:index]
      resources :users, only: [:index] do
        get '/projects', to: 'users/projects#index'
      end
    end
  end
end
