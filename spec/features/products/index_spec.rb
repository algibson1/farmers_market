require "rails_helper"

RSpec.describe "Products index page" do
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

#   User Story 3, Child Index 

# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes
# (data from each column that is on the child table)

  xit "displays each product in the system along with attributes" do
    visit "/products"

    expect(page).to have_content("All Produce")
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Fruit with seeds")
    expect(page).to have_content("Cost: $1.76 per pound")
    expect(page).to have_content("Red Delicious Apple")
    expect(page).to have_content("Cost: $1.21 per pound")
    expect(page).to have_content("Golden Delicious Apple")
    expect(page).to have_content("Concord Grape")
    expect(page).to have_content("Seedless Fruit")
    expect(page).to have_content("Cost: $1.11 per pound")
    expect(page).to have_content("Romanesco Broccoli")
    expect(page).to have_content("Vegetable")
    expect(page).to have_content("Cost: $4.32 per pound")
    expect(page).to have_content("Grown at Scarlet Orchards")
    expect(page).to have_content("Grown at Golden Orchards")
    expect(page).to have_content("Grown at Lilac Vineyard")
    expect(page).to have_content("Grown at Valerie's Veggies")
  end

      #   User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index
  it "has a link at the top for the products index page" do
    visit "/products"

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
    visit "/products"

    within("#header") do
      expect(page).to have_content("All Farms")
      click_on "All Farms"
      expect(current_path).to eq("/farms")
    end
  end



# User Story 15, Child Index only shows `true` Records 

# As a visitor
# When I visit the child index
# Then I only see records where the boolean column is `true`

  it "only shows records of fruits" do
    visit "/products"
    expect(page).to have_content("Fruit with seeds")
    expect(page).to have_content("Seedless Fruit")
    expect(page).to_not have_content("Vegetable")
    expect(page).to_not have_content("Romanesco Broccoli")
  end

#   User Story 18, Child Update From Childs Index Page 

# As a visitor
# When I visit the `child_table_name` index page or a parent `child_table_name` index page
# Next to every child, I see a link to edit that child's info
# When I click the link
# I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14

  it "has a link to edit each product" do
    visit "/products" 

    expect(page).to have_content("Edit Info For Pink Lady Apple")
    expect(page).to have_content("Edit Info For Red Delicious Apple")
    expect(page).to have_content("Edit Info For Golden Delicious Apple")
    expect(page).to have_content("Edit Info For Concord Grape")

    click_link("Edit Info For Pink Lady Apple")

    expect(current_path).to eq("/products/#{@lady.id}/edit")
  end
end