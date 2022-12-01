class PagesController < ApplicationController
  require 'date'
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user_cars = current_user.cars
    @user_bookings = current_user.bookings
  end

  def profile
    @user = current_user
  end

  def update_profile
    @user.update(user_params)
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo, :avatar)
  end
end
