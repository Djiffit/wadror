class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  scope :active, -> { where activity:true }
  scope :retired, -> { where activity:[nil,false] }
  validates :name, length:{minimum: 1}
  validates :year, numericality: {greater_than_or_equal_to: 1042}, length:{minimum: 4}
  validate :validateYear

  def validateYear
      if !year.nil? and year <= Time.now.year and year <= Date.today.year
      else
        errors.add(:year, "is incorrect!")
      end
  end

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

  def average
    a = Array.new
    if (ratings.count>0)
      summa = 0.0
      b = beers.reject{|b| (b.average_rating.eql? 'No rating')}
      b.each {|bee| summa = summa + bee.average_rating}
      palautus = [(summa/b.size).round(1), b.size, average_rating]
      if palautus.last.nil?
        a << 0
        return a << 0
      end
      return palautus
    else
      a << 0
      return a << 0
    end
  end

  def countBeers
    return beers.count
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average.last||0) }
    @top_breweries = sorted_by_rating_in_desc_order.first(3)
  end
end


