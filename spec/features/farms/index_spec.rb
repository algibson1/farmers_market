require "rails_helper"

RSpec.describe "Farm index page" do
  before do
    @scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
  end

# User Story 1, Parent Index 
# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system
  it "displays all farm names" do
    visit "/farms"

    expect(page).to have_content("Scarlet Orchards")
    expect(page).to have_content("Golden Orchards")
    expect(page).to have_content("Lilac Vineyard")
    expect(page).to have_content("Valerie's Veggies")
  end

  it "only has the farm names" do
    visit "/farms"

    expect(page).to_not have_content("acres")
    expect(page).to_not have_content("true")
  end


#   User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created
  it "should include dates that farm records were created" do
    visit "/farms"

    expect(page).to have_content("Date Posted: #{@scarlet.created_at}")
    expect(page).to have_content("Date Posted: #{@gold.created_at}")
    expect(page).to have_content("Date Posted: #{@lilac.created_at}")
    expect(page).to have_content("Date Posted: #{@valerie.created_at}")
  end

  it "should list farms by date created" do 
    visit "/farms"
    
    expect(page.all(".farm")[0]).to have_content("Valerie's Veggies")
    expect(page.all(".farm")[1]).to have_content("Lilac Vineyard")
    expect(page.all(".farm")[2]).to have_content("Golden Orchards")
    expect(page.all(".farm")[3]).to have_content("Scarlet Orchards")
  end
    #   User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index
  it "has a link at the top for the products index page" do
    visit "/farms"

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
    visit "/farms"

    within("#header") do
      expect(page).to have_content("All Farms")
      click_on "All Farms"
      expect(current_path).to eq("/farms")
    end
  end

  # User Story 11, Parent Creation 
      #FIRST HALF OF STORY TESTED HERE
  # As a visitor
  # When I visit the Parent Index page
  # Then I see a link to create a new Parent record, "New Parent"
  # When I click this link
  # Then I am taken to '/parents/new' where I  see a form for a new parent record
  it "has a link to create a new farm record" do
    visit "/farms"

    expect(page).to have_content("New Farm")
    click_on "New Farm"
    expect(current_path).to eq("/farms/new")
  end
  ### rest of test will need to be in spec for create page


  # User Story 17, Parent Update From Parent Index Page 

  # As a visitor
  # When I visit the parent index page
  # Next to every parent, I see a link to edit that parent's info
  # When I click the link
  # I should be taken to that parent's edit page where I can update its information just like in User Story 12
  it "has a link by each farm to edit that farm" do
    visit "/farms"

    expect(page).to have_content("Edit Info For Scarlet Orchards")
    expect(page).to have_content("Edit Info For Golden Orchards")
    expect(page).to have_content("Edit Info For Lilac Vineyard")
    expect(page).to have_content("Edit Info For Valerie's Veggies")

    click_link("Edit Info For Scarlet Orchards")
    expect(current_path).to eq("/farms/#{@scarlet.id}/edit")
  end

end