module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    if ratings.count > 0
      sum = 0
      ratings.map { |r| r.score }.sum
    else
      return 'No rating'
    end
  end

end

