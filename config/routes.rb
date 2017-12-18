Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/login", to: "login#create"
  delete "/logout", to: "login#destroy"
  resources :users
  resources :account_activations, only: :edit
  resources :relationships, only: %i(create destroy)
  resources :buy_requests, only: %i(index destroy update)
  resources :likes, only: %i(create destroy)
  resources :books, only: %i(index show) do
    resources :reviews, only: :create
  end
  resources :comments, only: :create
end
