class CarsController < ApplicationController
  def index
    @cars = policy_scope(Car)
  end

  def show
    @car = Car.find(params[:id])
    authorize @car
    @booking = Booking.new
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car
    @car.save
    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
    @car = Car.find(params[:id])
    authorize @car
  end

  def update
    @car = Car.find(params[:id])
    authorize @car
    @car.update(car_params)
    redirect_to car_path(@car)
  end

  def destroy
    @car = Car.find(params[:id])
    authorize @car
    @car.destroy
    redirect_to "/", status: :see_other
  end

  def dashboard
    @cars = Car.all
  end

  private

  def car_params
    params.require(:car).permit(:user, :brand, :model, :color, :location, :engine_size, :price, :plate, photos: [])
  end
end
