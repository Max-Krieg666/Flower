Rails.application.routes.draw do
  root 'products#index'

  resources :orders, except: [:create, :new] do
    patch 'submit_order', on: :member
  end

  resources :users

  resources :line_items

  resources :products

  get 'login' => "sessions#new", as: :login

  post 'login' => "sessions#create"

  patch 'logout' => "sessions#destroy", as: :logout
end
