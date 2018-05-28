Rails.application.routes.draw do
  root "admin/neighborhoods#index"

  devise_for :users
  resources :users, only: [:show]

  namespace :admin do
    resources :neighborhoods, only: [:show, :index]

    resources :neighborhoods do
      resources :blocks, only: [:new, :create]
    end

    resources :blocks, only: [:show, :edit, :update]
    resources :cleanings, only: [:create, :edit, :update, :destroy]
  end

end
