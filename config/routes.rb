Rails.application.routes.draw do
  get 'homes/index'
  root to: 'homes#index'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
end