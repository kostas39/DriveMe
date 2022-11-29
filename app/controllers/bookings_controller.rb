class BookingsController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @booking = Booking.new
  end

  def create
    @car = Car.find(params[:car_id])
    @reservations = @car.bookings
    available = []
    dates = params[:booking]
    start_date = dates["start_date"].to_date
    end_date = dates["end_date"].to_date
    @reservations.each do |reservation|
      if (reservation.start_date..reservation.end_date).overlaps?(start_date..end_date)
        available << 1
        else nil
      end
    end
    if available.count > 0
      @car = Car.find(params[:car_id])
      @booking = Booking.new
      flash.alert = "Dates not available"
      render :new, status: :unprocessable_entity
    else
      @car = Car.find(params[:car_id])
      @booking = Booking.new(booking_params)
      @booking.car = @car
      @booking.user = current_user
      if @booking.save
        redirect_to car_path(@car.id)
      else
        render :new
      end
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to cars_path
  end

  private

  def booking_params
    params.require(:booking).permit(:car_id, :user_id, :start_date, :end_date)
  end
end
