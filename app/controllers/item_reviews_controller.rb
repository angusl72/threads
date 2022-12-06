class ItemReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create]

  def new
    @item_review = ItemReview.new
    authorize @item_review
  end

  def create
    @item_review = ItemReview.new(item_review_params)
    @item_review.booking = @booking
    authorize @item_review
    if @item_review.save!
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @item_review
    @item_review = ItemReview.find(params[:id])
    @item_review.destroy
    redirect_to booking_path(@item_review.booking), status: :see_other
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def item_review_params
    params.require(:item_review).permit(:rating, :feedback, :booking_id, :id)
  end
end
