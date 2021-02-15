class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @boat = Boat.find(params[:boat_id])
    @reservation = Reservation.new
  end

  def create
    @boat = Boat.find(params[:boat_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save!
      redirect_to boat_reservation_path(@reservation)
    else
      render :new
    end
  end


  private

  def reservation_params
    params.require(:reservation).permit(:boat_id, :user_id, :begin_date, :end_date)
  end
end
