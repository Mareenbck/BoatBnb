class BoatsController < ApplicationController

  def index
    @boats = policy_scope(Boat)
    @markers = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude
      }
    end
  end

  def show
    @boat = Boat.find(params[:id])
    authorize @boat
    @reservation = Reservation.new
  end

  def new
    @boat = Boat.new
    authorize @boat
  end

  def create
    @boat = Boat.new(boat_params)
    @boat.user = current_user
    authorize @boat
    if @boat.save
      redirect_to boat_path(@boat)
    else
      render :new
    end
  end

  def edit
    @boat = Boat.find(params[:id])
    authorize @boat
    redirect_to edit_boat_path(@boat)
  end

  def update
    @boat = Boat.find(params[:id])
    authorize @boat
    @boat.update(boat_params)
  end

  def destroy
    @boat = Boat.find(params[:id])
    @boat.user = current_user
    authorize @boat
    @boat.destroy
    redirect_to dashboard_path
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :price, :category, :localisation, :capacity, photos: [])
  end
end
