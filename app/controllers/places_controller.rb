class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.all

    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.lat
      marker.lng place.lon
    end

  end

  def search
    lat = -25.480876
    lng = -49.304425
    #search = Place.search do
    #  keywords( params[:q] )
    #end

    #@places = search.results


    search = Place.search do
        #fulltext "{!func}geodist(location_ll, #{lat}, #{lng})"
        with(:location).in_radius( -25.480876, -49.304425, 1 )
        order_by(:score, :asc)
    end
    @places = search
    render 'index'
  end


  def nearby

    search = Place.search do
       keywords( params[:q] ) if params[:q].present?
       with(:location).in_radius( params[:lat], params[:lon], 10 )
       order_by(:score, :asc)
       #with(:geohash).near( -25.480876, -49.304425, :precision => 1)
    end

    @place =  Place.first
    @place.lat = params[:lat]
    @place.lon = params[:lon]

    search.results.unshift @place
    @places = search.results # Adiciona um lugar para traçar o trajeto # Adiciona um lugar para traçar o trajeto

    @distances = search

    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.lat
      marker.lng place.lon
    end

    render 'index'
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:title, :description, :lat, :lon, :address)
    end
end
