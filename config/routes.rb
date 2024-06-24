Rails.application.routes.draw do
  get "users/retired" => "users#retired", as: :retired_users
  get "users/all" => "users#all", as: :all_users
  patch "users/:id/retire" => "users#retire", as: :retire_user
  patch "users/:id/restore" => "users#restore", as: :restore_user

  resources :daily_reports
  resources :users
  devise_for :user

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#show"
end
