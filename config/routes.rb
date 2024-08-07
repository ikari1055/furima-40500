Rails.application.routes.draw do
  get 'categories/show'
  devise_for :users
  resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :categories, only: [:show]  # ここでcategoriesリソースを追加

  root 'items#index'
end
