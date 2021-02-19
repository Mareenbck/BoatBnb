class BoatsController < ApplicationController
  def index
    if params[:category] && params[:category] != "Category"
      @boats = policy_scope(Boat.where(category: params[:category]))
    else
      @boats = policy_scope(Boat)
    end

    if params[:capacity] && params[:capacity] != "Capacity"
      @boats = policy_scope(@boats.where(capacity: params[:capacity]))
    else
      @boats = policy_scope(@boats)
    end

    @markers = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { boat: boat }),
        image_url: helpers.asset_url('http://pngimg.com/uploads/anchor/anchor_PNG11.png')
      }
    end
  end

  def show
    @boat = Boat.find(params[:id])
    @boats = Boat.where(id: @boat.id)
    authorize @boat
    @reservation = Reservation.new

    @reviews = @boat.reviews

    @average_rating = average_rating

    @marker = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { boat: boat }),
        image_url: helpers.asset_url('http://pngimg.com/uploads/anchor/anchor_PNG11.png')
      }
    end
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
  end

  def update
    @boat = Boat.find(params[:id])
    authorize @boat

    if @boat.update(boat_params)
      redirect_to boat_path(@boat)
    else
      render :edit
    end
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
    params.require(:boat).permit(:name, :price, :category, :localisation, :capacity, :description, photos: [])
  end

  def average_rating
    ratings = @boat.reviews.pluck(:rating)
    ratings.length.zero? ? 0 : (ratings.sum / ratings.length).round
  end
end
