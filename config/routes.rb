# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :customer_accounts
  resources :teams_users, only: [:index]
  resources :apidocs, only: [:index]
  resources :profiles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
