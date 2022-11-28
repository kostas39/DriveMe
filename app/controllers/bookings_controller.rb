class BookingsController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @booking = Booking.new
  end

  def create
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

  def edit
    @booking = Booking.Find(params[:id])
  end

  def update
    @booking = Booking.Find(params[:id])
    if @booking.update(booking_params)
      redirect_to car_path(@car.id)
    else
      render :edit
    end
  end

  def destroy
    raise
    @booking = Booking.Find(params[:id])
    @booking.destroy
    redirect_to car_path(@car.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:car_id, :user_id, :start_date, :end_date)
  end
end
