Rails.application.routes.draw do
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"
  devise_for :users
resources :users, only: [:index, :show, :edit, :update]
resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]


end
