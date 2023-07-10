require "rails_helper"

RSpec.describe "Sort products alphabetically" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @red_d = @scarlet.products.create!(name: "Red Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.21)
    @lady = @scarlet.products.create!(name: "Pink Lady Apple", fruit: true, seeds: true, cost_per_pound: 1.76)
    @braeburn = @scarlet.products.create!(name: "Braeburn Apple", fruit: true, seeds: true, cost_per_pound: 1.71)
  end
  #   User Story 16, Sort Parent's Children in Alphabetical Order by name 

# As a visitor
# When I visit the Parent's children Index Page
# Then I see a link to sort children in alphabetical order
# When I click on the link
# I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order

it "has a link to sort products alphabetically on index page" do
  visit "/farms/#{@scarlet.id}/products"

  expect(page.all(".product")[0]).to have_content("Red Delicious Apple")
  expect(page.all(".product")[1]).to have_content("Pink Lady Apple")
  expect(page.all(".product")[2]).to have_content("Braeburn Apple")
  expect(page.all(".product")[0]).to_not have_content("Braeburn Apple")

  click_link("Alphabetize")

  expect(current_path).to eq("/farms/#{@scarlet.id}/products/sort")

  expect(page.all(".product")[0]).to have_content("Braeburn Apple")
  expect(page.all(".product")[1]).to have_content("Pink Lady Apple")
  expect(page.all(".product")[2]).to have_content("Red Delicious Apple")
  expect(page.all(".product")[0]).to_not have_content("Red Delicous Apple")
end
end