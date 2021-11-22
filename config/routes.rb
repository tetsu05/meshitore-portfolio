Rails.application.routes.draw do
  get 'homes/index'
  root to: 'homes#index'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update] do
    resources :events, only: [:index, :new, :create]
    resources :relationships, only: [:create, :destroy]
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'


  resources :notifications, only: :index  do
    collection do
      delete :destroy_all
    end
  end


end