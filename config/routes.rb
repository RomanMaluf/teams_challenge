# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :customer_accounts, except: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
