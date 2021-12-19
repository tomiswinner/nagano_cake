Rails.application.routes.draw do
  # devise_for :customers
  # devise_for :admins
  
  root :to => "homes#top"
  get "about", to: "homes#about", as: "about"
  resources :items, only: [:index,:show]
  
  
  namespace :admin do
    root :to => "homes#top"
    resources :genres, only: [:index,:create,:edit,:update]
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:show,:update]
    resources :order_items, only: [:update]
  end
  
  
  devise_for :customers, controllers: {
    sessions:        'customers/sessions',
    passwords:       'customers/passwords',
    registrations:   'customers/registrations',
  }
  
  devise_for :admins, controllers: {
    sessions:        'admins/sessions',
    passwords:       'admins/passwords',
    registrations:   'admins/registrations',
  }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end