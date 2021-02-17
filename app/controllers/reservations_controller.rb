class ReservationsController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_boat, only: [:new, :create]

  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.boat = @boat
    @reservation.total_price = sum_price(@boat.price, @reservation.end_date, @reservation.begin_date)
    if @reservation.save!
      redirect_to reservation_path(@reservation)
    else
      render :new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.user = current_user
    @reservation.boat = @boat
    @reservation.destroy
    redirect_to dashboard_path
  end

  private

  def set_boat
    @boat = Boat.find(params[:boat_id])
  end

  def reservation_params
    params.require(:reservation).permit(:begin_date, :end_date)
  end

  def sum_price(price_per_day, end_d, begin_d)
    price_per_day * (end_d.mjd - begin_d.mjd + 1)
  end
end
