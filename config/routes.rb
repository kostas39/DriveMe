Rails.application.routes.draw do
  devise_for :users
  root  to: "cars#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :cars
  # Defines the root path route ("/")
  # root "articles#index"

  get "dashboard", to: "pages#dashboard"
  resources :cars do
    resources :bookings, only: [:new, :create]
  end
  get "profile", to: "pages#profile"
  delete "/bookings/:id/delete", to: "bookings#destroy", as: :booking
end
