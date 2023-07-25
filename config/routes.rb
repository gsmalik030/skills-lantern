Rails.application.routes.draw do
  resources :courses
  get 'privacy_policy', to: 'pages#privacy_policy'
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
