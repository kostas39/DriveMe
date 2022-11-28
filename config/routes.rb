Rails.application.routes.draw do
##  get 'bookings/new'
##  get 'bookings/create'
##  get 'bookings/edit'
##  get 'bookings/update'
##  get 'bookings/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :cars
  # Defines the root path route ("/")
  # root "articles#index"

  resources :cars do
    resources :bookings, only: [:new, :create]
  end

 # resources :bookings, only: [:edit, :update]
  delete "/bookings/:id/delete", to: "bookings#destroy", as: :booking
end
