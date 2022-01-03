Rails.application.routes.draw do
  
  root :to => "homes#top"
  get "about", to: "homes#about", as: "about"
  resources :items, only: [:index,:show]
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  
  # cart_items routes
  resources :cart_items, only: [:index, :create, :destroy, :update]
  delete "cart_items", to: "cart_items#destroy_all", as: "destroy_all_cart_items"
  

  # orders routes
  resources :orders, only: [:new, :create, :index, :show] do 
    collection do
      get :confirm
      get :complete
    end
  end
  
  # customers routes
  get "customers/mypage", to: "customers#show", as: "customer_mypage"
  get "customers/confirm", to: "customers#confirm", as: "customer_confirm"
  get "customers/edit", to: "customers#edit", as: "customer_edit"
  patch "customers", to: "customers#update", as: "customer_update"
  
  
  
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
  
  devise_for :admins, path: "admin",controllers: {
    sessions:        'admins/sessions',
    passwords:       'admins/passwords',
    registrations:   'admins/registrations',
  }
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end