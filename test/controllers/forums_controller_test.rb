require 'test_helper'

class ForumsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
    @forum = forums(:one)
    #@user = users(:one)
    #sign_in @user

  end

  test "should get index" do
    get forums_url
    assert_response :success
  end

  test "should get new" do
    get new_forum_url(game_id: @forum.game_id)
    assert_response :success
  end

  test "should create forum" do
    assert_difference('Forum.count') do
      post forums_url, params: { forum: { entry: @forum.entry, game_id: @forum.game_id, title: @forum.title } }
    end

    assert_redirected_to forum_url(Forum.last)
  end

  test "should show forum" do
    get forum_url(@forum)
    assert_response :success
  end

  test "should get edit" do
    get edit_forum_url(@forum)
    assert_response :success
  end

  test "should update forum" do
    patch forum_url(@forum), params: { forum: { entry: @forum.entry, game_id: @forum.game_id, title: @forum.title } }
    assert_redirected_to forum_url(@forum)
  end

  test "should destroy forum" do
    assert_difference('Forum.count', -1) do
      delete forum_url(@forum)
    end

    assert_redirected_to forums_url
  end
end
