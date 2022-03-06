Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  get 'homes/top'
  get 'home/about'=>"homes#about"
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
  
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
