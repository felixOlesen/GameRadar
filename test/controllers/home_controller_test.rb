require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers

#Tests route to home page
  test "should get home" do
    get root_url
    assert_select'title', 'Game Forums'
    assert_select'h4', "If the game you're searching for isn't already in the database,"
    assert_select'h4', "it will be added when you press the search button."
    assert_response :success
  end

#Tests route to gb search method view
  test "should get gb_search" do
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
    get search_path, params: {search_games: " "}
    assert_response :success
    assert_select'h2', "Search Results:"
    assert_select'th', "Name"
    assert_select'th', "Deck"
    assert_select'th', "Original Release Date"
    assert_select'th', "Expected Release Date"
    assert_select'th', "Platforms"
  end

#Testing redirect to games index if gb search params is left blank
  test "should redirect to games index" do
      get '/users/sign_in'
      sign_in users(:one)
      post user_session_url
      get search_path, params: {search_games: ""}
      assert_redirected_to games_path
  end

#Testing path to contact page
  test "should get contact" do
    get contact_url
    assert_response :success
    assert_template layout: 'application'
    assert_select 'title', 'Game Forums'
    assert_select 'h1', 'Contact Us'
    assert_select 'p', 'Complete the following form to get in touch with us.'
  end

#Testing request contact method if no email is enetered in the input
  test "should post request contact but no email" do
    post request_contact_url

    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

#Tests if request contact method works
  test "should do post request contact" do
    post request_contact_url, params: {name: "Matthew", email: "matthew@me.com", message: "Hello"}
    assert_response :redirect
    assert_nil flash[:alert]
    assert_not_empty flash[:notice]
  end

end
