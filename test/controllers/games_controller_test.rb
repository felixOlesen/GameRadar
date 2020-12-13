require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

#Sets up game and signs in
  setup do
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
    @game = games(:one)
  end

#Tests games index path
  test "should get index" do
    get games_url
    assert_response :success
    assert_select'h1', "All Games:"
    assert_select'th', "Name"
    assert_select'th', "Original Release Date"
    assert_select'th', "Expected Release Date"
    assert_select'th', "Platforms"
  end

#tests path to getting new game
  test "should get new" do
    get new_game_url
    assert_response :success
  end

#Tests that the game is actually created
  test "should create game" do
    assert_difference('Game.count') do
      post games_url, params: { game: { deck: @game.deck, expected_release_day: @game.expected_release_day, expected_release_month: @game.expected_release_month, expected_release_year: @game.expected_release_year, gb_id: 0, image: @game.image, name: @game.name, og_release_date: @game.og_release_date, platforms: @game.platforms } }
    end

    assert_redirected_to game_url(Game.last)
  end

#Tests path to show specific game
  test "should show game" do
    get game_url(@game)
    assert_response :success
  end

#Tests path to edit specific game
  test "should get edit" do
    get edit_game_url(@game)
    assert_response :success
  end

#Tests update for specific game in games table
  test "should update game" do
    patch game_url(@game), params: { game: { deck: @game.deck, expected_release_day: @game.expected_release_day, expected_release_month: @game.expected_release_month, expected_release_year: @game.expected_release_year, gb_id: @game.gb_id, image: @game.image, name: @game.name, og_release_date: @game.og_release_date, platforms: @game.platforms } }
    assert_redirected_to game_url(@game)
  end

#Tests change in game count in game table after destroying a game object
  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete game_url(@game)
    end

    assert_redirected_to games_url
  end

#Tests redirect to login page if not logged in while attempting to access index
  test 'should redirect to login' do
      delete destroy_user_session_url
      get games_path
      assert_redirected_to new_user_session_url
  end

end
