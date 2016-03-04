class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  validates :name, length:{minimum: 1}
  validate :validate_style

  def validate_style
    styles = Style.all
    if !styles.include?(style)
      errors.add(:style, "beer style has to be defined")
    end
  end

  def average
    return 0.0 if ratings.empty?
    (ratings.map{ |r| r.score }.sum / ratings.count.to_f).round(1)
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average||0) }
    @top_beers = sorted_by_rating_in_desc_order.first(3)
  end

  def to_s
    return "#{name} by #{brewery.name}"
  end
end
