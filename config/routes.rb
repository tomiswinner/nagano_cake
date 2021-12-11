Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  
  
  namespace :admin do
    root :to => "homes#top"
    resources :genres, only: [:index,:create,:edit,:update]
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :customers, only: [:index,:showw,:edit,:update]
    resources :orders, only: [:show,:update]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end