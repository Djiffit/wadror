class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy
  has_secure_password

  validates :password, length: {minimum: 4}, format: { with: /[A-Z]/ }, format: {with: /[0-9]/} if not :password.nil?
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}

  include RatingAverage

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.brewery }.uniq
    rated.sort_by { |brewery| -rating_of_brewery(brewery) }.first
  end

  def rating_of_brewery(brewery)
    ratings_of = ratings.select{ |r| r.beer.brewery==brewery }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def favorite_style
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.style }.uniq
    rated.sort_by { |style| -rating_of_style(style) }.first
  end

  def rating_of_style(style)
    ratings_of = ratings.select{ |r| r.beer.style==style }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def self.top_raters
    a = Hash.new
    User.all.each do |u| a[u.id] = u.ratings.count end
    a = a.sort_by {|k,v| v}.reverse
    @top_raters = Array.new
    a.first(3).each {|k,v| (@top_raters << User.find(k))}
    return @top_raters
  end
end

