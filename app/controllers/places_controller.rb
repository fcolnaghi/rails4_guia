class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index

    @places = Place.search("*", facets: [:neighborhood_id, :city_id, :categories], :limit => 30, :page => params[:page] )

    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.lat if place.lat.present?
      marker.lng place.lon if place.lon.present?
    end

  end

  def autocomplete
    if params[:address].present?
      places = Place.search(params[:address], partial: true, fields: [ {address: :text_middle, order: :asc } ], :limit => 5).map(&:address).uniq
    end

    if params[:place].present?
      places = Place.search( params[:place],  partial: true,  fields: [ {title: :text_middle, order: {_score: :desc}}] , :limit => 5).map(&:title).uniq
    end

    respond_to do |format|
        format.json { render json: places, status: :ok }
    end
  end


  def search

    where = ( Neighborhood.search(params[:w]).map(&:id) || Place.search( params[:w], suggest: true, fields: [ {address: :text_middle} ], order: {_score: :desc}, page: params[:page],  per_page: 30  ) ) if params[:w].present?

    if params[:w].present? && params[:q].present?
      localizacao = Neighborhood.search(params[:w]).map(&:id)
      if localizacao.any?
        @places = Place.search( params[:q], suggest: true, where: { neighborhood_id: localizacao }, facets: [:rating, :categories, :city_id], page: params[:page],  per_page: 30 )
      else
        address = Place.search( params[:w], suggest: true, fields: [ {address: :text_middle} ], order: {_score: :desc} ).map(&:address).first
        @places = Place.search( params[:q], suggest: true, fields: [:title], facets: [:neighborhood, :rating, :categories, :city_id], where: {address: address }, page: params[:page],  per_page: 30 )
      end
    elsif params[:w].present?
      localizacao = Neighborhood.search(params[:w]).map(&:id)
      if localizacao.any?
        @places = Place.search( "*", suggest: true, where: { neighborhood_id: localizacao },facets: [:neighborhood, :rating, :categories, :city_id], order: {_score: :desc}, page: params[:page],  per_page: 30 )
      else
        @places = Place.search( params[:w], suggest: true, fields: [ {address: :text_middle} ],facets: [:neighborhood, :rating, :categories, :city_id], order: {_score: :desc}, page: params[:page],  per_page: 30 )
      end
    elsif params[:q].present?
      @places = Place.search(params[:q], suggest: true, facets: [:neighborhood, :rating, :categories, :city_id], order: { rating: :desc }, page: params[:page],  per_page: 30)
    else
      #@places = Place.search("*")
      redirect_to places_path()
      return
    end

    marks = @places.select { |p| p if p.lat }

    @hash = Gmaps4rails.build_markers(marks) do |place, marker|
      marker.lat place.lat unless place.lat.nil?
      marker.lng place.lon unless place.lon.nil?
    end

    render 'search'
  end


  def nearby

    search = Place.search do
       keywords( params[:q] ) if params[:q].present?
       with(:location).near([ params[:lat], params[:lon] ], 5 ) if (params[:lat].present?) && (params[:lon].present?)
       order_by(:score, :asc)
       #with(:geohash).near( -25.480876, -49.304425, :precision => 1)
    end

    @places = search.results # Adiciona um lugar para traçar o trajeto # Adiciona um lugar para traçar o trajeto

    @distances = search

    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.lat if place.lat.present?
      marker.lng place.lon if place.lon.present?
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
    @place.categories.build
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
      params.require(:place).permit(:title, :description, :address, :neighborhood_id, :number, :cep, :city_id, :state, :phone, category_ids: [])
    end
end
