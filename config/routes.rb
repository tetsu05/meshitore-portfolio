Rails.application.routes.draw do
  get 'homes/index'
  root to: 'homes#index'
  devise_for :users
  resources :users, only: %i[show index edit update]
  resources :posts
end
