require "rails_helper"

RSpec.describe "Farm products index page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @lady = @scarlet.products.create!(name: "Pink Lady Apple", fruit: true, seeds: true, cost_per_pound: 1.76)
    @red_d = @scarlet.products.create!(name: "Red Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.21)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @golden_d = @gold.products.create!(name: "Golden Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.11)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @concord = @lilac.products.create!(name: "Concord Grape", fruit: true, seeds: false, cost_per_pound: 1.89)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
    @romanesco = @valerie.products.create!(name: "Romanesco Broccoli", fruit: false, seeds: false, cost_per_pound: 4.32)
  end

#   User Story 5, Parent Children Index 

# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes
# (data from each column that is on the child table)

  it "displays all products associated with one farm, and those product attributes" do
    visit "/farms/#{@scarlet.id}/products"

    expect(page).to have_content("Produce from Scarlet Orchards")
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Fruit with seeds")
    expect(page).to have_content("Cost: $1.76 per pound")
    expect(page).to have_content("Red Delicious Apple")
    expect(page).to have_content("Cost: $1.21 per pound")
  end

  it "does not display any other farms or their products" do
    visit "/farms/#{@scarlet.id}/products"

    expect(page).to_not have_content("Golden Orchards")
    expect(page).to_not have_content("Seedless Fruit")
    expect(page).to_not have_content("Vegetable")
    expect(page).to_not have_content("Golden Delicious Apple")
  end

  it "can display a different farm's products" do
    visit "/farms/#{@lilac.id}/products"

    expect(page).to have_content("Produce from Lilac Vineyard")
    expect(page).to have_content("Concord Grape")
    expect(page).to have_content("Seedless Fruit")
  end

  it "can display yet another farm's products" do
    visit "/farms/#{@valerie.id}/products"

    expect(page).to have_content("Produce from Valerie's Veggies")
    expect(page).to have_content("Romanesco Broccoli")
    expect(page).to have_content("Vegetable")
  end

#   User Story 8, Child Index Link

# As a visitor
# When I visit any page on the site
# Then I see a link at the top of the page that takes me to the Child Index
  it "has a link at the top for the products index page" do
    visit "/farms/#{@scarlet.id}/products"

    within("#header") do
      expect(page).to have_content("All Produce")
      click_on "All Produce"
      expect(current_path).to eq("/products")
    end
  end


# User Story 9, Parent Index Link

# As a visitor
# When I visit any page on the site
# Then I see a link at the top of the page that takes me to the Parent Index

  it "has a link at the top for the farms index page" do
    visit "/farms/#{@scarlet.id}/products"

    within("#header") do
      expect(page).to have_content("All Farms")
      click_on "All Farms"
      expect(current_path).to eq("/farms")
    end
  end
end