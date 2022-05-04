# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    mount Sidekiq::Web => '/sidekiq'
    mount Ckeditor::Engine => '/ckeditor'
    get 'home/index'
    devise_for :users

    resources :users
    resources :dreams
    resources :categories
    resources :tags
    resources :aboutes
    resources :comments, only: %i[create destroy]
    resources :replies

    namespace :admin do
      resources :users, only: %i[index] do
        patch 'update_block_status', on: :member
      end
    end

    root to: 'home#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
