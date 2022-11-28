Rails.application.routes.draw do
##  get 'bookings/new'
##  get 'bookings/create'
##  get 'bookings/edit'
##  get 'bookings/update'
##  get 'bookings/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resourcers :car do
    resources :booking, only: [:new, :create]
  end

  resources :booking, only: [:edit, :update, :destroy]
end
