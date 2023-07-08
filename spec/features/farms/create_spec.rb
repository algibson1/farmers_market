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

  it "works when pick your own box is not checked" do
    #because an unchecked box is not included in params
    #which causes the attribute to end up as nil, not false
    visit "/farms/new"
    
    fill_in "Farm Name", with: "Bob's Berries"
    fill_in "Acres", with: "236"
    click_on "Submit"
    
    bob = Farm.all[0]
    expect(bob.pick_your_own).to eq(false)
    expect(page).to have_content("Bob's Berries")
    expect(page).to have_content("Date Posted: #{bob.created_at}")
  end

  #==============Edge Case==============================================================
  xit "raises an error if acres field is left blank" do
    visit "/farms/new"

    fill_in "Farm Name", with: "Bob's Berries"
    click_on "Submit"

    expect(current_path).to eq("/farms/new")
    expect(page).to raise_error("Acres cannot be left blank. If acreage is unknown, please enter 0")
  end

  xit "raises an error if name field is left blank" do
    visit "/farms/new"

    fill_in "Acres", with: "654"
    click_on "Submit"

    expect(current_path).to eq("/farms/new")
    expect(page).to raise_error("Please enter a farm name")
  end

  xit "raises an error if the user puts special characters in farm name field" do
    visit "/farms/new"

    fill_in "Farm Name", with: "Bob's_Berries^"
    fill_in "Acres", with: "432"
    click_on "Submit"
    
    expect(current_path).to eq("farms/new")
    expect(page).to raise_error("The following characters are not permitted in names: ~!@#$%^&*()_-+={}[]<>?")
  end

  xit "raises an error if the user puts anything besides numbers in acres field" do
    visit "/farms/new"

    fill_in "Farm Name", with: "Bob's Berries"
    fill_in "Acres", with: "forty-two"
    click_on "Submit"

    expect(current_path).to eq("farms/new")
    expect(page).to raise_error("Please only use digits 0-9 for acres")
  end
  #==============Edge Case==============================================================


end

