require 'rails_helper'

RSpec.describe "viewing a ship", type: :system do
  it "allows a user to view a ship", pending: true do
    visit ships_path
    click_on("X-Wing")
    expect(page).to have_content("X-Wing")
  end
end