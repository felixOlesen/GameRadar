require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_select'title', 'Game Radar'
    assert_select'div', 'Game Radar'
    assert_select'div', 'Welcome to the ultimate Game Release Radar!'
    assert_response :success
  end

  test "should get contact" do
      get contact_url
      assert_response :success
      assert_template layout: 'application'
      assert_select 'title', 'Game Radar'
      assert_select 'div', 'Contact Us'
      assert_select'div', 'Complete the following form to get in touch with us.'
  end

end
