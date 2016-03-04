
class RatingsController < ApplicationController

  def index
    make_sure_these_things_are_in_cache
    @top_beers = Rails.cache.read "beer top 3"
    @top_breweries = Rails.cache.read "brewery top 3"
    @top_raters = Rails.cache.read "top raters"
    @recent = Rails.cache.read "recent ratings"
    @ratings = Rails.cache.read "rating all"
    @top_styles = Rails.cache.read "style top"
  end

  def make_sure_these_things_are_in_cache
    Rails.cache.write("beer top 3", Beer.top(3), timeToLive: 1.day) if not Rails.cache.exist?("beer top 3")
    Rails.cache.write("brewery top 3", Brewery.top(3), timeToLive: 1.day) if not Rails.cache.exist?("brewery top 3")
    Rails.cache.write("top raters", User.top_raters, timeToLive: 1.day) if not Rails.cache.exist?("top raters")
    Rails.cache.write("recent ratings", Rating.recent, timeToLive: 1.day) if not Rails.cache.exist?("recent ratings")
    Rails.cache.write("rating all", Rating.all, timeToLive: 1.day) if not Rails.cache.exist?("rating all")
    Rails.cache.write("style top", Style.top, timeToLive: 1.day) if not Rails.cache.exist?("style top")
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if @rating.save
      ["beerlist-name", "beerlist-brewery", "beerlist-style", "beerlist-rating", "beerlist-"].each{ |f| expire_fragment(f) }
      ["brewerylist-name", "brewerylist-year", "brewerylist-rating", "brewerylist-"].each{ |f| expire_fragment(f) }
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end


  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    ["brewerylist-name", "brewerylist-year", "brewerylist-rating", "brewerylist-"].each{ |f| expire_fragment(f) }
    ["beerlist-name", "beerlist-brewery", "beerlist-style", "beerlist-rating", "beerlist-"].each{ |f| expire_fragment(f) }
    redirect_to :back
  end
end