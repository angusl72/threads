class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]

  def index
    @bookings = policy_scope(Booking)
    @bookings = Booking.all
  end

  def show
    authorize @booking
  end

  def update_status
    if @booking.update_status(booking_params)
      redirect_to @booking, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking

      if @booking.save
        redirect_to @booking, notice: "Booking was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end
  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :booking_price)
  end

end
