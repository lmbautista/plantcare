# frozen_string_literal: true

Rails.application.routes.draw do
  root "users#welcome"

  get "users",            to: redirect("signup")
  get "signin",           to: "sessions#new"
  get "signout",          to: "sessions#destroy"
  get "signup",           to: "users#new"
  get "confirmation",     to: "users#confirmation"
  get "welcome",          to: "users#welcome"

  resources :users, only: %w(show new create update) do
    member do
      get "profile", to: "users#edit"
    end
  end

  resources :sessions, only: %w(new create destroy)
  resources :plantcares
  resources :water_pumps, only: %w(edit update)
  resources :watering_schedules, except: %w(show destroy)
end
