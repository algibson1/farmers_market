require "rails_helper"

RSpec.describe "Products index page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @lady = @scarlet.products.create!(name: "Pink Lady Apple", fruit: true, seeds: true, cost_per_pound: 1.76)
    @red_d = @scarlet.products.create!(name: "Red Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.21)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @golden_d = @gold.products.create!(name: "Golden Delicioius Apple", fruit: true, seeds: true, cost_per_pound: 1.11)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @concord = @lilac.products.create!(name: "Concord Grape", fruit: true, seeds: false, cost_per_pound: 1.89)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
    @romanesco = @valerie.products.create!(name: "Romanesco Broccoli", fruit: false, seeds: false, cost_per_pound: 4.32)
  end

#   User Story 3, Child Index 

# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes
# (data from each column that is on the child table)
  it "displays each product in the system along with attributes" do
    visit "/products"

    expect(page).to have_content("All Produce")
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Fruit with seeds")
    expect(page).to have_content("Cost: $1.76 per pound")
    expect(page).to have_content("Red Delicious Apple")
    expect(page).to have_content("Cost: $1.21 per pound")
    expect(page).to have_content("Concord Grape")
    expect(page).to have_content("Seedless Fruit")
    expect(page).to have_content("Cost: $1.11 per pound")
    expect(page).to have_content("Romanesco Broccoli")
    expect(page).to have_content("Vegetable")
    expect(page).to have_content("Cost: $4.32 per pound")
    expect(page).to have_content("Scarlet Orchards")
    expect(page).to have_content("Golden Orchards")
    expect(page).to have_content("Lilac Vineyard")
    expect(page).to have_content("Valerie's Veggies")
  end
end