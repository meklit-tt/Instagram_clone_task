Rails.application.routes.draw do
resources :favorites, only: [:create, :destroy]
end
