class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy
  has_secure_password
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: { with: /[A-Z]/ }, format: {with: /[0-9]/}
  include RatingAverage
end
