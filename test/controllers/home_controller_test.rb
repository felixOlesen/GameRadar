require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_select'title', 'Game Radar'
    assert_select'h1', 'Game Radar'
    assert_select'p', 'Welcome to the ultimate Game Release Radar!'
    assert_response :success
  end

end
