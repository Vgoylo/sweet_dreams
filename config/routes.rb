Rails.application.routes.draw do
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

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
