Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'home/index'
  devise_for :users

  resources :users do
    patch 'update_block_status', on: :member
  end
  resources :dreams
  resources :categories
  resources :tags
  resources :aboutes
  resources :comments, only: %i[create destroy]
  resources :replies

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
