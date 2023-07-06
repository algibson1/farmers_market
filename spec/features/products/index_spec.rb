require "rails_helper"

RSpec.describe "Products index page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @lady = @scarlet.products.create!(name: "Pink Lady Apple", fruit: true, seeds: true, cost_per_pound: 1.76)
    require 'pry'; binding.pry
  end

#   User Story 3, Child Index 

# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes
# (data from each column that is on the child table)
  it "displays each product in the system along with attributes" do
    visit "/products"

    expect(page).to have_content("Pink Lady Apple")
    expect(page).to have_content("This fruit has seeds")
    expect(page).to have_content("Cost: $1.76 per pound")
  end
end