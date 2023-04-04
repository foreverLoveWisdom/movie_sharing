# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'movies#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :movies, only: %i[index show new create]

  get 'analytics', to: 'analytics#index'
end
