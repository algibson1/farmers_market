require "rails_helper"

RSpec.describe "Farms edit page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
  end
  # User Story 12, Parent Update 
  #Test included in show page spec: 
          # As a visitor
          # When I visit a parent show page
          # Then I see a link to update the parent "Update Parent"
          # When I click the link "Update Parent"
          # Then I am taken to '/parents/:id/edit' 

  #REST OF TEST IN THIS SPEC
  #where I  see a form to edit the parent's attributes:
  
  it "has a form autofilled with current attribute info" do
    visit "/farms/#{@scarlet.id}/edit"
    
    expect(page).to have_content("All Farms")
    expect(page).to have_content("All Produce")
    expect(page).to have_content("Edit Farm Data")
    expect(page).to have_field("Farm Name", with: @scarlet.name)
    expect(page).to have_checked_field("Pick Your Own")
    expect(page).to have_field("Acres", with: @scarlet.acres)
    expect(page).to have_button("Update")
  end
  
  it "has unchecked pick your own field for farms without Upick" do
    visit "/farms/#{@lilac.id}/edit"
    
    expect(page).to have_content("All Farms")
    expect(page).to have_content("All Produce")
    expect(page).to have_content("Edit Farm Data")
    expect(page).to have_field("Farm Name", with: @lilac.name)
    expect(page).to have_unchecked_field("Pick Your Own")
    expect(page).to have_field("Acres", with: @lilac.acres)
    expect(page).to have_button("Update")
  end
  # When I fill out the form with updated information
  # And I click the button to submit the form
  # Then a `PATCH` request is sent to '/parents/:id',
  # the parent's info is updated,
  # and I am redirected to the Parent's Show page where I see the parent's updated info

  it "can update info about the farm" do
    id = @scarlet.id
    expect(Farm.find(id).name).to eq("Scarlet Orchards")
    expect(Farm.find(id).pick_your_own).to eq(true)

    visit "/farms/#{id}/edit"

    fill_in "Farm Name", with: "Royal Reds"
    uncheck "Pick Your Own"
    click_on "Update"

    expect(Farm.find(id).name).to eq("Royal Reds")
    expect(Farm.find(id).pick_your_own).to eq(false)

    expect(current_path).to eq("/farms/#{id}")
    expect(page).to have_content("Royal Reds")
    expect(page).to_not have_content("Scarlet Orchards")
    expect(page).to have_content("354")
    expect(page).to have_content("This Farm Does Not Offer Pick-Your-Own Service")

    visit "/farms"

    expect(page).to_not have_content("Scarlet Orchards")
  end

  #================================================================
  #Add edge casing for valid input similar to in create spec if I have time
  #================================================================
end