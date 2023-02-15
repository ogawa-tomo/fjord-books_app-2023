Rails.application.routes.draw do
  get 'users/show'
  root to: "books#index"
  devise_for :users
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
