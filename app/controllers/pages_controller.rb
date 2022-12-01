class PagesController < ApplicationController
  require 'date'
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user_cars = current_user.cars
    @user_bookings = current_user.bookings
  end
end
