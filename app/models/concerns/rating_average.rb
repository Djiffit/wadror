module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    if ratings.count > 0
      (ratings.map { |r| r.score }.sum.to_f/ratings.count).round(1)
    else
      return 'No rating'
    end
  end

end

