class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show, :list]
  before_action :skip_if_cached, only: [:index]

  def skip_if_cached
    @order = params[:order]
    return render :index if fragment_exist?("brewerylist-#{@order}")
  end

  # GET /breweries
  # GET /breweries.json

  def index
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
    @breweries = Brewery.all

    order = params[:order] || 'name'

    @retired_breweries = case order
                           when 'name' then @retired_breweries.sort_by{ |b| b.name }
                           when 'rating' then @retired_breweries.sort_by{|b| b.average}.reverse
                           when 'year' then @retired_breweries.sort_by{|b| b.year}.reverse
                         end

    @active_breweries = case order
                          when 'name' then @active_breweries.sort_by{ |b| b.name }
                          when 'rating' then @active_breweries.sort_by{|b| b.average}.reverse
                          when 'year' then @active_breweries.sort_by{|b| b.year}.reverse
                        end

    if session[:sort] == (params[:order].to_s)
      @retired_breweries = @retired_breweries.reverse
      @active_breweries = @active_breweries.reverse
      session[:sort] = nil
    else
      session[:sort] = params[:order].to_s
    end

  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :activity, (not brewery.activity)

    new_status = brewery.activity? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
    return render :show if fragment_exist?(@brewery.cache_key)
  end

  def list
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)
    ["brewerylist-name", "brewerylist-year", "brewerylist-rating", "brewerylist"].each{ |f| expire_fragment(f) }

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    ["brewerylist-name", "brewerylist-year", "brewerylist-rating", "brewerylist"].each{ |f| expire_fragment(f) }

    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    if current_user.admin

      ["brewerylist-name", "brewerylist-year", "brewerylist-rating", "brewerylist"].each{ |f| expire_fragment(f) }
      @brewery.destroy
      respond_to do |format|
        format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to(@brewery, notice:'Action only allowed for admin users!')
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_brewery
    @brewery = Brewery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brewery_params
    params.require(:brewery).permit(:name, :year, :activity)
  end
end
