Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "admin/neighborhoods#index"

  namespace :admin do
    resources :neighborhoods, only: [:show, :index]

    resources :neighborhoods do
      resources :blocks, only: [:new, :create]
    end

    resources :blocks, only: [:show]
    resources :cleanings, only: [:create, :edit, :update, :destroy]
  end
end
