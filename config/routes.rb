Rails.application.routes.draw do 
  resources :enrollments do
    get :students_enrolled, on: :collection
  end
  devise_for :users
  resources :courses do
    get :courses_enrolled, :unapproved, :pending_review, :created, on: :collection
    member do
      patch :approve, :unapprove
    end
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :update, :show]
  get 'privacy_policy', to: 'pages#privacy_policy'
  root 'pages#home'
end
