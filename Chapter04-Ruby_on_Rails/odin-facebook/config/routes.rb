Rails.application.routes.draw do

  get 'friends/index'
  get 'friends/destroy'
  get '/posts', to: redirect('/')
  devise_for :users, :controllers => { registrations: 'registrations'}
  resources :comments
  resources :friend_requests, only: [:index, :create, :destroy, :update]
  resources :posts, only: [:create, :destroy]
  resources :users, only: [:index, :show]
  resources :likes, only: [:create, :destroy]
  root 'static_pages#home'
end
