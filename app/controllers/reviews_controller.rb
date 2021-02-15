class ReviewsController < ApplicationController
    def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @reservation = Reservation.find(params[:reservation_id])
    @review.reservation = @reservation
    if @review.save
      redirect_to boat_path(@boat)
    else
      render :new
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
