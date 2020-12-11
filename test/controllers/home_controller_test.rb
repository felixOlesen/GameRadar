require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers

  test "should get home" do
    get root_url
    assert_select'title', 'Game Forums'
    assert_select'h2', 'Welcome!'
    assert_select'h4', 'Please search for any game you want to talk about.'
    assert_select'h4', "If the game you're searching for isn't already in the database,"
    assert_select'h4', "it will be added when you press the search button."
    assert_response :success
  end

  test "should get gb_search" do
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
    get search_path, params: {search_games: "test"}
    assert_response :success
    assert_select'h2', "Search Results:"
    assert_select'th', "Name"
    assert_select'th', "Deck"
    assert_select'th', "Original Release Date"
    assert_select'th', "Expected Release Date"
    assert_select'th', "Platforms"
  end

  test "should redirect to games index" do
      get '/users/sign_in'
      sign_in users(:one)
      post user_session_url
      get search_path
      assert_redirected_to games_path
  end

  test "should get contact" do
    get contact_url
    assert_response :success
    assert_template layout: 'application'
    assert_select 'title', 'Game Forums'
    assert_select 'h1', 'Contact Us'
    assert_select 'p', 'Complete the following form to get in touch with us.'
  end

  test "should post request contact but no email" do
    post request_contact_url

    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

  test "should do post request contact" do
    post request_contact_url, params: {name: "Matther", email: "matthew@me.com", message: "Hello"}
    assert_response :redirect
    assert_nil flash[:alert]
    assert_not_empty flash[:notice]
  end

end
