require 'rails_helper'

RSpec.describe User, type: :model do

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings it doesn't exist" do
      expect(user.favorite_style).to be_nil
    end

    it "is the style of the only rated beer" do
      style = FactoryGirl.create(:style)
      beer = FactoryGirl.create(:beer, style: style)
      rating = FactoryGirl.create(:rating, beer: beer)
      expect(user.favorite_style).to eq("IPA")
    end

    it "is the style with highest rating" do
      beer = create_beer_with_rating(user, 10)
      beerr = Beer.create(name:"Noppa", style:FactoryGirl.create(:style, name:"Weizen"))
      rating = FactoryGirl.create(:rating, score:50, beer:beerr, user:user)
      expect(user.favorite_style).to eq("Weizen")
    end

  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings it doesn't exist" do
      expect(user.favorite_brewery).to be_nil
    end

    it "is the brewery of the only rated beer" do
      beer = create_beer_with_rating(user, 20)
      expect(user.favorite_brewery).to eq("anonymous")
    end

    it "is the style with highest rating" do
      beer = create_beer_with_rating(user, 10)
      brewery = FactoryGirl.create(:brewery, name:"panimo", year:"1999")
      beerr = Beer.create(name:"Noppa", style:FactoryGirl.create(:style), brewery:brewery)
      rating = FactoryGirl.create(:rating, score:50, beer:beerr, user:user)
      expect(user.favorite_brewery).to eq("panimo")
    end
  end

  it "has username set correctly" do
    user = User.new username:"Pekka"
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end


    it "rejects passwords without numbers" do
      user = User.create username:"Pekka", password:"Pekka", password_confirmation:"Pekka"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end

    it "rejects too short passwords" do
      user = User.create username:"Pekka", password:"Pe1", password_confirmation:"Pe1"
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating user, score
    end
  end

  def create_beer_with_rating(user, score)
    style = FactoryGirl.create(:style)
    beer = FactoryGirl.create(:beer, style:style)
    FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
    beer
  end
end
