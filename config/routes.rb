Rails.application.routes.draw do
  devise_for :users
  authenticated do
    root to: "events#index", as: :authenticated_root
  end
  resources :events do
    resource :like
    resource :comment
  end
  root to: "home#index"
end
