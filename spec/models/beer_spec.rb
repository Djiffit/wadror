require 'rails_helper'

RSpec.describe Beer, type: :model do
  let!(:style){style = FactoryGirl.create(:style)}
  it "is saved if style and name are set" do
    beer = Beer.create name:"Tortilla", style:style
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a proper name" do
    beer = Beer.create name:"", style:style
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Pistorasaia"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
