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
    expect(page).to have_content("All Produce")
    expect(page).to have_content("Enter information for a new farm")
    expect(page).to have_field("Farm Name")
    expect(page).to have_unchecked_field("Pick Your Own")
    expect(page).to have_field("Acres")
    expect(page).to have_button(type: "submit")
  end
  
  it "Accepts user input to create a new farm" do
    visit "/farms/new"
    
    expect(Farm.all).to eq([])
    # When I fill out the form with a new parent's attributes:
    
    fill_in "Farm Name", with: "Bob's Berries"
    check "Pick Your Own"
    fill_in "Acres", with: "236"
    # And I click the button "Create Parent" to submit the form
    click_on "Submit"
    
    # Then a `POST` request is sent to the '/parents' route,
    # a new parent record is created,      
    expect(Farm.all.size).to eq(1)
    bob = Farm.all[0]
          
    # and I am redirected to the Parent Index page 
    #where I see the new Parent displayed.
    expect(current_path).to eq("/farms")
    expect(page).to have_content("Bob's Berries")
    expect(page).to have_content("Date Posted: #{bob.created_at}")
  end

  xit "works when pick your own box is not checked" do
    
  end

  xit "raises an error if the user puts in invalid data" do
    #such as letters into the acres field
    #or special characters in farm name field?
  end

end

