Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  root 'items#index'
end
