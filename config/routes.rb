Rails.application.routes.draw do
  root "neighborhoods#index"

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' } 
  resources :users, only: [:show, :edit, :update]
  resources :users do 
    member do 
      get 'toggle_reminders' #TODO Remove this custom function, and use user update
    end
  end

  resources :neighborhoods, only: [:show, :index, :new, :create, :edit, :update]
  
  resources :neighborhoods do
    resources :blocks, only: [:new, :create]
    resources :events, only: [:new, :create]
  end

  resources :blocks, only: [:show, :edit, :update, :destroy]
  resources :blocks do
    member do
      post 'unadopt'
      post 'adopt'
    end
  end
    
  resources :cleanings, only: [:create, :edit, :update, :destroy]

  namespace :admin do
    resources :neighborhoods, only: [:index]
    resources :users, only: [:index]
    resources :users do
      collection do
        post 'promote'
        post 'demote'
      end
    end
  end

end
