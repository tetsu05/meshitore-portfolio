Rails.application.routes.draw do
  get 'homes/index'
  root to: 'homes#index'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end