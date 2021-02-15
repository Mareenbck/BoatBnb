Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boats do
    resources :reviews, only: [:new, :create, :destroy]
    resources :bookings, except: :destroy
  end

  resource :dashboard, only: [:show]

end
