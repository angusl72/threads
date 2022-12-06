class SellerReviewsController < ApplicationController
  before_action :set_seller_review, only: [:show, :edit, :update, :destroy]
  before_action :set_booking, only: [:new, :create, :edit, :update, :destroy]

  def new
    @seller_review = SellerReview.new
    authorize @seller_review
  end

  def create
    @seller_review = SellerReview.new(seller_review_params)
    @seller_review.booking = @booking
    authorize @seller_review
      if @seller_review.save!
        redirect_to item_path(@booking.item), status: :see_other
      else
        render :new, status: :unprocessable_entity
      end
  end

  def edit
    authorize @seller_review
  end

  def update
    authorize @seller_review
    @seller_review.update(seller_review_params)
    if @seller_review.save!
      redirect_to item_path(@booking.item), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @seller_review
    @seller_review.destroy
  end

  private

  def set_seller_review
    @seller_review = SellerReview.find(params[:id])
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def seller_review_params
    params.require(:seller_review).permit(:rating, :feedback, :booking_id, :id)
  end

end
