require "rails_helper"

RSpec.describe "Editting a product record" do
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
  
  #   User Story 14, Child Update 

# As a visitor
# When I visit a Child Show page
# Then I see a link to update that Child "Update Child"
# When I click the link
# I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
# When I click the button to submit the form "Update Child"
# Then a `PATCH` request is sent to '/child_table_name/:id',
# the child's data is updated,
# and I am redirected to the Child Show page where I see the Child's updated information
  it "is linked to from the product show page" do
    visit "/products/#{@lady.id}"

    expect(page).to have_link("Update Product")

    click_link("Update Product")
    expect(current_path).to eq("/products/#{@lady.id}/edit")
    expect(page).to have_content("Edit Information For Pink Lady Apple")
    expect(page).to have_field("Name", with: "Pink Lady Apple")
    expect(page).to have_checked_field("Fruit")
    expect(page).to have_checked_field("Seeds")
    expect(page).to have_field("Cost Per Pound", with: 1.76)
  end

  it "can update an existing product" do
    visit "/products/#{@lady.id}"
    expect(page).to have_content("Pink Lady Apple")
    expect(page).to_not have_content("Cripps Pink Apple")

    click_link("Update Product")

    fill_in("Name", with: "Cripps Pink Apple")
    click_button("Update Product")

    expect(current_path).to eq("/products/#{@lady.id}")
    expect(page).to have_content("Cripps Pink Apple")
    expect(page).to_not have_content("Pink Lady Apple")
  end

end