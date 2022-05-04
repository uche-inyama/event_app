Rails.application.routes.draw do
  devise_for :users
  authenticated do
    root to: "host/events#index", as: :authenticated_root
  end
  
  resources :events, module: 'host'
  resources :events do
    resource :like
    resource :comment
    resource :event_registration, only: [:create, :destroy], as: :join
  end
  root to: "host/events#index"
  get "event/:id/details", to: "host/events#details", as: 'details'
end
