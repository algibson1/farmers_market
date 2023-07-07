require "rails_helper"

RSpec.describe "Products show page" do
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
#   User Story 4, Child Show 

# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes
# (data from each column that is on the child table)

  it "shows one product and that products info" do
    visit "/products/#{@lady.id}"

    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Fruit with seeds")
    expect(page).to have_content("Cost: $1.76 per pound")
    expect(page).to have_content("Grown at Scarlet Orchards")
  end

  it "doesn't show info for any other product" do
    visit "/products/#{@lady.id}"

    expect(page).to_not have_content("Seedless fruit")
    expect(page).to_not have_content("Vegetable")
    expect(page).to_not have_content("Red Delicious Apple")
    expect(page).to_not have_content("Lilac Vineyard")
  end

    #   User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index
  it "has a link at the top for the products index page" do
    visit "/products/#{@lady.id}"

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
    visit "/products/#{@lady.id}"

    within("#header") do
      expect(page).to have_content("All Farms")
      click_on "All Farms"
      expect(current_path).to eq("/farms")
    end
    save_and_open_page
  end
end