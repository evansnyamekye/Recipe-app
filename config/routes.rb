Rails.application.routes.draw do
  get 'public_recipes/index'
  get 'public_recipes/show'
  get 'home/index'
  devise_for :users, sign_out_via: [:get, :delete]
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"

  resources :users, only: [:index] do
    resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    patch 'update_name', to: 'users#update_name', as: 'update_name'
  end

  resources :recipes, only: [] do
    resources :ingredients, only: [:new, :create, :edit, :update, :destroy]
    patch 'toggle_public', on: :member
  end

  resources :public_recipes, only: [:index, :show,]
    end

