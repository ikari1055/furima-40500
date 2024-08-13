Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/create'
  devise_for :users
  
  resources :items do
    resources :orders, only: [:index, :create]
  end

  root 'items#index'
end
