Rails.application.routes.draw do
    root 'sessions#new'
    resources :sessions, only: [:new, :create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :users
    resources :posts do
      collection do
        post :confirm
      end
    end
  end
