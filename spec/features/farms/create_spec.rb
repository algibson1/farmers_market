require "rails_helper"

RSpec.describe "create a new farm record page" do
  # User Story 11, Parent Creation 
  # user story included in index_spec()
        # As a visitor
        # When I visit the Parent Index page
        # Then I see a link to create a new Parent record, "New Parent"
        # When I click this link
        # Then I am taken to '/parents/new' 
        
        
  # user story for THIS page:     
        #where I  see a form for a new parent record
        
  it "contains a form to enter relevant attribute data" do
    visit "/farms/new"
    
    expect(page).to have_content("All Farms")
    expect(page).to have_content("All Products")
    expect(page).to have_content("Enter information for a new farm")
    expect(page).to have_field("Farm Name")
    expect(page).to have_unchecked_field("Pick Your Own")
    expect(page).to have_field("Acres")
    expect(page).to have_button("Submit")
  end
        # When I fill out the form with a new parent's attributes:
        # And I click the button "Create Parent" to submit the form
        # Then a `POST` request is sent to the '/parents' route,
        # a new parent record is created,      
        # and I am redirected to the Parent Index page 
  it "Accepts user input to create a new farm" do
    visit "/farms/new"

    fill_in "Farm Name", with: "Bob's Berries"
    check "Pick Your Own"
    fill_in "Acres", with: "236"
    click_on "Submit"

    expect(current_path).to eq("/farms")
    expect(page).to have_content("Bob's Berries")
  end

        
  # back to index page for test?      
        #where I see the new Parent displayed.

end

