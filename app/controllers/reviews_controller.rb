class ReviewsController < ApplicationController
  skip_after_action :verify_authorized
  def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.new
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.reservation = @reservation
    if @review.save
      redirect_to dashboard_path
    else
      render "reviews/new_review"
    end
  end

  def detroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to boat_path(@boat)
  end


  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
