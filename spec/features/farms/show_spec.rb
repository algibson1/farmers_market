require "rails_helper"

RSpec.describe "Farm show page" do
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


# User Story 7, Parent Child Count

# As a visitor
# When I visit a parent's show page
# I see a count of the number of children associated with this parent

  it "displays count of all products sold by that farm" do
    visit "/farms/#{@scarlet.id}"

    expect(page).to have_content("Varietals Offered: 2")

    visit "/farms/#{@gold.id}"

    expect(page).to have_content("Varietals Offered: 1")
  end

    #   User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index
  it "has a link at the top for the products index page" do
    visit "/farms/#{@scarlet.id}"

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
    visit "/farms/#{@scarlet.id}"

    within("#header") do
      expect(page).to have_content("All Farms")
      click_on "All Farms"
      expect(current_path).to eq("/farms")
    end
  end

#   User Story 10, Parent Child Index Link

# As a visitor
# When I visit a parent show page ('/parents/:id')
# Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')

  it "links to the farm's offered produce" do
    visit "/farms/#{@scarlet.id}"

    expect(page).to have_content("Produce From This Farm")
    click_on "Produce From This Farm"
    expect(current_path).to eq("/farms/#{@scarlet.id}/products")
  end

#   User Story 12, Parent Update 

# As a visitor
# When I visit a parent show page
# Then I see a link to update the parent "Update Parent"
# When I click the link "Update Parent"
# Then I am taken to '/parents/:id/edit' 
# REST OF USER STORY IN SPEC FOR EDIT PAGE

  it "has a link to update the farm's info" do
    visit "/farms/#{@scarlet.id}"

    expect(page).to have_content("Update Farm")
    click_on "Update Farm"
    expect(current_path).to eq("/farms/#{@scarlet.id}/edit")
  end

#   User Story 19, Parent Delete 

# As a visitor
# When I visit a parent show page
# Then I see a link to delete the parent
# When I click the link "Delete Parent"
# Then a 'DELETE' request is sent to '/parents/:id',
# the parent is deleted, and all child records are deleted
# and I am redirected to the parent index page where I no longer see this parent

  it "has a link to delete the farm" do
    visit "/farms/#{@scarlet.id}"

    expect(@scarlet).to be_a(Farm)
    expect(page).to have_content("Delete Scarlet Orchards")
    click_link("Delete Scarlet Orchards")

    expect(current_path).to eq("/farms")
    expect(page).to_not have_content("Scarlet Orchards")
  end

  it "deletes all associated products when a farm is deleted" do
    visit "/products"
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("Red Delicious Apple")
    
    visit "/farms/#{@scarlet.id}"
    click_link("Delete Scarlet Orchards")

    visit "/products"

    expect(page).to_not have_content("Pink Lady Apple")
    expect(page).to_not have_content("Red Delicious Apple")
  end
end