class BeerClub < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships

  def to_s
    to_s = name
  end
end
