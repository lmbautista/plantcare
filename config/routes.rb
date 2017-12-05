Rails.application.routes.draw do
  root 'users#welcome'

  resources :users, only: %w( show new create ) do
    member do
      get 'profile', to: 'users#edit'
    end
  end

  resources :sessions, only: %w( create destroy )

  resources :plantcares, only: %w( index new create edit update destroy )

  get 'signin',           to: 'sessions#new'
  get 'signup',           to: 'users#new'
  get 'confirmation',     to: 'users#confirmation'
  get 'welcome',          to: 'users#welcome'
end
