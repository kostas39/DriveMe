class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @cars = policy_scope(Car)
    if params[:query].present?
      @cars = Car.search_by_brand_and_model_and_location(params[:query])
    else
      @cars = policy_scope(Car)
    end


    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: { car: car })
      }
    end
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

  def car_active_toggle
    if car.active == true
      then car.active = false
      redirect_back(fallback_location: 'something')
      flash.alert = "This car can't be booked anymore"
    else
      car.active = true
      redirect_back(fallback_location: 'something')
      flash.alert = "This car is now bookable"
    end
  end

  private

  def car_params
    params.require(:car).permit(:user, :brand, :model, :color, :location, :engine_size, :price, :plate, :active, photos: [])
  end
end
