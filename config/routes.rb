Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home#index"
  resources :users, only: [:index]
patch 'update_name', to: 'users#update_name', as: 'update_name'

resources :inventories, except: [:update] do
  resources :inventory_foods, only: [:new, :create, :destroy]
end 

end
