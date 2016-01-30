class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
    to_s = "#{beer.name} #{score}"
  end
end
