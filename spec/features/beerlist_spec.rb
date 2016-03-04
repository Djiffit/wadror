require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
  it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end
  it "shows beers in alphabetical order", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(find('table').find('tr:nth-child(2)')).to have_content("Fastenbier")
    expect(find('table').find('tr:nth-child(4)')).to have_content("Nikolai")
  end


  it "sorts beers by brewery when clicked on brewery header", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    click_on('brewery')
    expect(find('table').find('tr:nth-child(2)')).to have_content("Ayinger")
    expect(find('table').find('tr:nth-child(3)')).to have_content("Koff")
    expect(find('table').find('tr:nth-child(4)')).to have_content("Schlenkerla")
  end

  it "sorts beers by style when clicked on style header", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    click_on('style')
    expect(find('table').find('tr:nth-child(2)')).to have_content("Nikolai")
    expect(find('table').find('tr:nth-child(4)')).to have_content("Lechte Weisse")
  end
end