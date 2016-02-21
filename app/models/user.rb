class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy
  has_secure_password
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: { with: /[A-Z]/ }, format: {with: /[0-9]/}
  include RatingAverage

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    rates = ratings
    styles = Style.all
    return rates[0].beer.style.name if ratings.count == 1
    average = 0.0
    paras = favorite_style_iterator(average, rates, styles)
    return paras
  end

  def favorite_style_iterator(average, rates, styles)
    paras = nil
    styles.each do |s|
      score = 0.0
      rates.each do |r|
        score += r.score if r.beer.style == (s)
      end
      score = score/beers.where(style: s).count if score > 0
      if score > average
        average = score
        paras = s
      end
    end
    return paras.name
  end

  def favorite_brewery
    return nil if ratings.empty?
    breweries = Brewery.all
    rates = ratings
    average = 0.0
    paras = favorite_brewery_iterator(average, breweries, rates)
    return paras.name
  end

  def favorite_brewery_iterator(average, breweries, rates)
    paras = nil
    breweries.each do |b|
      score = 0.0
      count = 0.0
      rates.each do |r|
        if r.beer.brewery == b
          count = count + 1
          score += r.score
        end
      end
      score = (score/count) if count > 0
      if score > average
        paras = b
        average = score
      end
    end
    return paras
  end
end

