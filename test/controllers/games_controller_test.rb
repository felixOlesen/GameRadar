require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get games_url
    assert_response :success
  end

  test "should get new" do
    get new_game_url
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post games_url, params: { game: { deck: @game.deck, expected_release_day: @game.expected_release_day, expected_release_month: @game.expected_release_month, expected_release_year: @game.expected_release_year, gb_id: @game.gb_id, image: @game.image, name: @game.name, og_release_date: @game.og_release_date, platforms: @game.platforms } }
    end

    assert_redirected_to game_url(Game.last)
  end

  test "should show game" do
    get game_url(@game)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_url(@game)
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { deck: @game.deck, expected_release_day: @game.expected_release_day, expected_release_month: @game.expected_release_month, expected_release_year: @game.expected_release_year, gb_id: @game.gb_id, image: @game.image, name: @game.name, og_release_date: @game.og_release_date, platforms: @game.platforms } }
    assert_redirected_to game_url(@game)
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete game_url(@game)
    end

    assert_redirected_to games_url
  end
end
