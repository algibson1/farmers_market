require "rails_helper"

RSpec.describe "Farm products index page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @red_d = @scarlet.products.create!(name: "Red Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.21)
    @lady = @scarlet.products.create!(name: "Pink Lady Apple", fruit: true, seeds: true, cost_per_pound: 1.76)
    @braeburn = @scarlet.products.create!(name: "Braeburn Apple", fruit: true, seeds: true, cost_per_pound: 1.71)
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

    #   User Story 16, Sort Parent's Children in Alphabetical Order by name 

# As a visitor
# When I visit the Parent's children Index Page
# Then I see a link to sort children in alphabetical order
# When I click on the link
# I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order

  it "has a link to sort products alphabetically" do
    visit "/farms/#{@scarlet.id}/products"

    expect(page.all(".product")[0]).to have_content("Red Delicious Apple")
    expect(page.all(".product")[1]).to have_content("Pink Lady Apple")
    expect(page.all(".product")[2]).to have_content("Braeburn Apple")
    expect(page.all(".product")[0]).to_not have_content("Braeburn Apple")
    click_link("Alphabetize")
    
    expect(current_path).to eq("/farms/#{@scarlet.id}/products")

    expect(page.all(".product")[0]).to have_content("Braeburn Apple")
    expect(page.all(".product")[1]).to have_content("Pink Lady Apple")
    expect(page.all(".product")[2]).to have_content("Red Delicious Apple")
    expect(page.all(".product")[0]).to_not have_content("Red Delicous Apple")
  end

  #   User Story 18, Child Update From Childs Index Page 

# As a visitor
# When I visit the `child_table_name` index page or a parent `child_table_name` index page
# Next to every child, I see a link to edit that child's info
# When I click the link
# I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14

  it "has a link to edit each product" do
    visit "/farms/#{@scarlet.id}/products" 

    expect(page).to have_content("Edit Info For Pink Lady Apple")
    expect(page).to have_content("Edit Info For Red Delicious Apple")

    click_link("Edit Info For Pink Lady Apple")

    expect(current_path).to eq("/products/#{@lady.id}/edit")
  end

#   User Story 21, Display Records Over a Given Threshold 

# As a visitor
# When I visit the Parent's children Index Page
# I see a form that allows me to input a number value
# When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
# Then I am brought back to the current index page with only the records that meet that threshold shown.

  it "has a form to filter records by cost" do
    visit "/farms/#{@scarlet.id}/products"

    expect(page).to have_content("Red Delicious Apple")
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Braeburn Apple")
    expect(page).to have_button("Only return records with a price above")
    fill_in("cost threshold", with: 1.50)
    click_button("Only return records with a price above")

    expect(page).to_not have_content("Red Delicious Apple")
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Braeburn Apple")
  end
end