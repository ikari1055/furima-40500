Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:new, :create, :index, :show]

  root 'items#index'
end
