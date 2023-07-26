Rails.application.routes.draw do 
  resources :enrollments
  devise_for :users
  resources :courses do
    resources :lessons
  end
  resources :users, only: [:index, :edit, :update, :show]
  get 'privacy_policy', to: 'pages#privacy_policy'
  root 'pages#home'
end
