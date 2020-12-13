require 'test_helper'

class ForumsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  #signs in and sets up forum from fixture
  setup do
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
    @forum = forums(:one)
    #@user = users(:one)
    #sign_in @user

  end

  #Test for forums index path
  test "should get index" do
    get forums_url
    assert_response :success
    assert_select'h1', "All Forum Posts:"
    assert_select'th', "Game"
    assert_select'th', "Title"
    assert_select'th', "Date"
  end

  #Test for creating new forum post
  test "should get new" do
    get new_forum_url(game_id: @forum.game_id)
    assert_response :success
  end

  #Testing change in Forum table count after new forum is created
  test "should create forum" do
    assert_difference('Forum.count') do
      post forums_url, params: { forum: { entry: @forum.entry, game_id: @forum.game_id, title: @forum.title } }
    end

    assert_redirected_to forum_url(Forum.last)
  end

  #Tests show path for specific forum post
  test "should show forum" do
    get forum_url(@forum)
    assert_response :success
  end

  #Tests edit path for specific forum
  test "should get edit" do
    get edit_forum_url(@forum)
    assert_response :success
  end

  #Testing if forum post change properly
  test "should update forum" do
    patch forum_url(@forum), params: { forum: { entry: @forum.entry, game_id: @forum.game_id, title: @forum.title } }
    assert_redirected_to forum_url(@forum)
  end

  #Tests forum count after one forum is destroyed
  test "should destroy forum" do
    assert_difference('Forum.count', -1) do
      delete forum_url(@forum)
    end

    assert_redirected_to forums_url
  end

  #tests if the page will redirect to login if signe out and trying to access any index pages
  test 'should redirect to login' do
      delete destroy_user_session_url
      get forums_path
      assert_redirected_to new_user_session_url
  end
end
