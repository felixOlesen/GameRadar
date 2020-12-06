require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  setup do
    @game = games(:one)
  end

  test "visiting the index" do
    visit games_url
    assert_selector "h1", text: "Games"
  end

  test "creating a Game" do
    visit games_url
    click_on "New Game"

    fill_in "Deck", with: @game.deck
    fill_in "Expected release day", with: @game.expected_release_day
    fill_in "Expected release month", with: @game.expected_release_month
    fill_in "Expected release year", with: @game.expected_release_year
    fill_in "Gb", with: @game.gb_id
    fill_in "Image", with: @game.image
    fill_in "Name", with: @game.name
    fill_in "Og release date", with: @game.og_release_date
    fill_in "Platforms", with: @game.platforms
    click_on "Create Game"

    assert_text "Game was successfully created"
    click_on "Back"
  end

  test "updating a Game" do
    visit games_url
    click_on "Edit", match: :first

    fill_in "Deck", with: @game.deck
    fill_in "Expected release day", with: @game.expected_release_day
    fill_in "Expected release month", with: @game.expected_release_month
    fill_in "Expected release year", with: @game.expected_release_year
    fill_in "Gb", with: @game.gb_id
    fill_in "Image", with: @game.image
    fill_in "Name", with: @game.name
    fill_in "Og release date", with: @game.og_release_date
    fill_in "Platforms", with: @game.platforms
    click_on "Update Game"

    assert_text "Game was successfully updated"
    click_on "Back"
  end

  test "destroying a Game" do
    visit games_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game was successfully destroyed"
  end
end
