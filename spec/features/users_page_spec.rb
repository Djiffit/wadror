require 'rails_helper'
include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "page " do
    let!(:user){user = FactoryGirl.create(:user, username:"Kookos", password:"Pahkina1", password_confirmation:"Pahkina1")}
    let!(:beer){beer = FactoryGirl.create(:beer, brewery:FactoryGirl.create(:brewery, name:"Poppoo"))}
    it "shows favorite style with one rating" do
      sign_in(username:"Kookos", password:"Pahkina1")
      FactoryGirl.create(:rating, score:33,  beer:beer, user:user)
      visit user_path(user)
      expect(page).to have_content 'Favorite style: Lager'
    end

    it "shows favorite style with multiple ratings" do
      sign_in(username:"Kookos", password:"Pahkina1")
      FactoryGirl.create(:rating, score:50,  beer:beer, user:user)
      FactoryGirl.create(:rating, score:33,  beer:FactoryGirl.create(:beer, name:"pooep"), user:user)
      visit user_path(user)
      expect(page).to have_content 'Favorite style: Lager'
    end

    it "shows favorite brewery with one rating" do
      sign_in(username:"Kookos", password:"Pahkina1")
      FactoryGirl.create(:rating, score:33,  beer:beer, user:user)
      visit user_path(user)
      expect(page).to have_content 'Favorite brewery: Poppoo'
    end

    it "shows favorite brewery with multiple ratings" do
      sign_in(username:"Kookos", password:"Pahkina1")
      FactoryGirl.create(:rating, score:50,  beer:beer, user:user)
      FactoryGirl.create(:rating, score:33,  beer:FactoryGirl.create(:beer, name:"pooep"), user:user)
      visit user_path(user)
      expect(page).to have_content 'Favorite brewery: Poppoo'
    end

  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "displays all given ratings" do
    user = FactoryGirl.create(:user, username:"Kookos", password:"Pahkina1", password_confirmation:"Pahkina1")
    sign_in(username:"Kookos", password:"Pahkina1")
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:33,  beer:beer, user:user)
    visit user_path(user)
    expect(page).to have_content 'anonymous'
    expect(page).to have_content '33'
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating user, score
    end
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
    beer
  end

end