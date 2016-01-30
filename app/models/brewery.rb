class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print
    puts name
    puts "Year of establishment: #{year}"
    puts "Number of beers: #{beers.count}"
  end

  def restart
    self.year = 2016
    self.name = "#{name} Reborn"
    puts "Changed year to 2016"
    puts "Rebranded to #{name}"
  end

  def average_ratings
    if (ratings.count>0)
      summa = 0.0
      b = beers.reject{|b| (b.average_rating.eql? 'No rating')}
      b.each {|bee| summa = summa + bee.average_rating}
      palautus = [(summa/b.size).round(1), b.size, average_rating]
    end
  end
end


