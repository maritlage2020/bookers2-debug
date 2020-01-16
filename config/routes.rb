Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books, only: [:new, :create, :destroy, :show,:index,:edit,:update] do
  	resources :favorites, only: [:create, :destroy]
  end
  root 'home#top'
  get 'home/about'

end