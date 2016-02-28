class Style < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers

  def self.top
    a = Hash.new
    Style.all.each do |u| a[u.id] = u.ratings.average(:score).to_i end
    a = a.sort_by{|k,v| v}.reverse
    @top_styles = Array.new
    a.first(3).each {|k,v| (@top_styles << Style.find(k))}
    return @top_styles
  end

  def average
    if ratings.count > 0
    b = ratings.average(:score).to_i
    else
      return 0
      end
    return b
  end

end
