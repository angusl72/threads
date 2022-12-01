class SellerReviewsController < ApplicationController
  before_action :set_seller_review, only: [:show, :edit, :update, :destroy]

  def index

  end

  def show

  end

  def new
    @seller_review = SellerReview.new
  end

  def create
    @seller_review = SellerReview.new(seller_review_params)
    #need to add redirection to item page
  end

  def edit

  end

  def update
    @seller_review.update(seller_review_params)
    #need to add redirection to item page
  end

  def destroy
    @seller_review.destroy
    #need to add redirection to item page
  end

  private

  def set_seller_review
    @seller_review = SellerReview.find(params[:id])
  end

  def seller_review_params
    params.require(:seller_review).permit(:rating, :feedback)
  end

end
