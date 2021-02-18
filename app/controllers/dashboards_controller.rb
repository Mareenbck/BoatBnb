class DashboardsController < ApplicationController
 skip_after_action :verify_authorized

  def show
    @boats = Boat.where(user: current_user)
    @reservations = Reservation.where(user: current_user)

    @review = Review.new
    # authorize current_user
  end

end
