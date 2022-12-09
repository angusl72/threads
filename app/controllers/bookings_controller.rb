class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update]
  before_action :set_item, only: %i[new create]

  def index
    @bookings = policy_scope(Booking)
  end

  def show
    authorize @booking
  end

  def update
    authorize @booking
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.status = "Pending"
    @booking.item = @item
    @booking.booking_price = @item.price
    authorize @booking
      if @booking.save!
        redirect_to item_path(@item)
      else
        render :new, status: :unprocessable_entity
      end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :booking_price, :item_id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def total_booking_days(booking)
    @days = ((booking.end_date - booking.start_date) / 1.day).to_i
  end
  helper_method :total_booking_days

  def total_price(booking)
    @total_price = booking.item.price.to_i * total_booking_days(booking)
  end
  helper_method :total_price

end
