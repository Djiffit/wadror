class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :brewery
  belongs_to :user
  scope :recent, -> {Rating.order("created_at").limit(6)}
  validates :score, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 50, only_integer: true}
  def to_s
    to_s = "#{beer.name} got #{score} points"
  end
end
