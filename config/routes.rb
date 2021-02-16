Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boats do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, except: [:new, :create] do
    resources :reviews, only: [:new, :create, :destroy]

  end

  resource :dashboard, only: [:show]

end
