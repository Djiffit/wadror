require 'rails_helper'
include Helpers

describe "Beer" do
  before :each do
    FactoryGirl.create(:user)
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can be added if it is valid" do
    brewery = FactoryGirl.create(:brewery)
    style = FactoryGirl.create(:style)
    sign_in(username:"Pekka", password:"Foobar1")
    visit beers_path
    click_link "New Beer"
    fill_in('beer_name', with:"Karamelli")
    click_button "Create Beer"
    expect(page).to have_content 'Beer was successfully created.'
    expect(page).to have_link 'Karamelli'
  end

  it "displays error message when creating with wrong values" do
    brewery = FactoryGirl.create(:brewery)
    visit beers_path
    click_link "New Beer"
    fill_in('beer_name', with:"")
    click_button "Create Beer"
    expect(page).to have_content 'Name is too short'
    end

end