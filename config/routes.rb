Rails.application.routes.draw do
  devise_for :users
  authenticated do
    root to: "events#index", as: :authenticated_root
  end
  resources :events do
    resource :like
    resource :comment
    resource :event_registration, only: [:create, :destroy], as: :join
  end
  root to: "events#index"
  get "event/:id/details", to: "events#details", as: 'details'
end
