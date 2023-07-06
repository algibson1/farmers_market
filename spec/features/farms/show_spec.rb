require "rails_helper"

RSpec.describe "Farm show page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
  end

#   User Story 2, Parent Show 

# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes
# (data from each column that is on the parent table)
  it "contains attributes for an individual farm" do
    visit "/farms/#{@scarlet.id}"

    expect(page).to have_content("Scarlet Orchards")
    expect(page).to have_content("This Farm Offers Pick-Your-Own Service")
    expect(page).to have_content("Acres: 354")

    expect(page).to_not have_content("Golden Orchards")
    expect(page).to_not have_content("Lilac Vineyard")
    expect(page).to_not have_content("Valerie's Veggies")
  end

  it "can display attributes for a different farm" do
    visit "/farms/#{@lilac.id}"

    expect(page).to have_content("Lilac Vineyard")
    expect(page).to have_content("This Farm Does Not Offer Pick-Your-Own Service")
    expect(page).to have_content("Acres: 234")

    expect(page).to_not have_content("Scarlet Orchards")
    expect(page).to_not have_content("Golden Orchards")
    expect(page).to_not have_content("Valerie's Veggies")
  end
end