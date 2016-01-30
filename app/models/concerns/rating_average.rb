module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    if ratings.count > 0
      ratings.average(:score).round(1)
    else
      return 'No rating'
    end
  end

end

