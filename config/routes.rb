Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boats do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, except: [:new, :create] do
    resources :reviews, only: [:create, :destroy]
  end

  resource :dashboard, only: [:show]

  patch '/validate/:id', to: 'reservations#validate', as: :validate
  patch '/deny/:id', to: 'reservations#deny', as: :deny

end
