class DashboardController < ApplicationController

  def show
    @boats = Boat.where(user: current_user)
    @reservations = Reservation.where(user: current_user)
  end

end
