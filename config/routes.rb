Rails.application.routes.draw do
  resources :daily_reports do
    resource :thumbs_up, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end
  devise_for :user

  get "index" => "index#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "index#index"
end
