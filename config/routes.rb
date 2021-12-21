Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'

  get 'homes/about' => 'homes#about'
  resources :users, only:[:show, :index, :edit, :update]
  resources :books, only:[:show, :index, :create, :edit, :update, :destroy]
end
