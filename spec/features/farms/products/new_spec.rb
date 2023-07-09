require "rails_helper"

RSpec.describe "Create new products for farms" do
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
#   User Story 13, Parent Child Creation 

# As a visitor
# When I visit a Parent Children Index page
# Then I see a link to add a new adoptable child for that parent "Create Child"
# When I click the link
# I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
# When I fill in the form with the child's attributes:
# And I click the button "Create Child"
# Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
# a new child object/row is created for that parent,
# and I am redirected to the Parent Childs Index page where I can see the new child listed
  it "can be linked to from the farm's product index page" do
    visit "/farms/#{@scarlet.id}/products"

    expect(page).to have_content("Add New Product")
    click_link "Add New Product"

    expect(current_path).to eq("/farms/#{@scarlet.id}/products/new")
    expect(page).to have_field("Product Name")
    expect(page).to have_unchecked_field("Fruit")
    expect(page).to have_unchecked_field("Seeds")
    expect(page).to have_field("Cost Per Pound")
    expect(page).to have_button("Add Product")
  end

  it "can create a new product for that farm" do
    visit "/farms/#{@scarlet.id}/products"
    expect(page).to_not have_content("Braeburn Apple")

    click_link "Add New Product"

    fill_in("Product Name", with: "Braeburn Apple")
    check("Fruit")
    check("Seeds")
    fill_in("Cost Per Pound", with: 1.29)
    click_button("Add Product")

    expect(current_path).to eq("/farms/#{@scarlet.id}/products")
    expect(page).to have_content("Braeburn Apple")
  end
end