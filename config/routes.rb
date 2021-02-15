Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boats do
    resources :reviews, only: [:new, :create, :destroy]
    resources :reservations, except: :destroy
  end

  resources :dashboard, only: [:show]

end
