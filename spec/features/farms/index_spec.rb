require "rails_helper"

RSpec.describe "Farm index page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
  end

# User Story 1, Parent Index 
# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system
  it "displays all farm names" do
    visit "/farms"

    expect(page).to have_content("Scarlet Orchards")
    expect(page).to have_content("Golden Orchards")
    expect(page).to have_content("Lilac Vineyard")
    expect(page).to have_content("Valerie's Veggies")
  end

  it "only has the farm names" do
    visit "/farms"

    expect(page).to_not have_content("acres")
    expect(page).to_not have_content("true")
  end
end