class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user_cars = current_user.cars
    @user_bookings = current_user.bookings
  end
end
