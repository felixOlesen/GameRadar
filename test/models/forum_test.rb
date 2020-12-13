require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
#Sets up test file with fixtures
  setup do
      @game = games(:one)
      @user = users(:one)
  end

#Tests validation for invalid forum posts
  test 'should not save without title' do
      forum = Forum.new
      forum.user = @user
      forum.entry = 'Forum entry sample'
      forum.save
      refute forum.valid?
  end

#tests validation for valid forum post
  test 'should save valid forum' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.game = @game
      forum.user = @user

      forum.save
      assert forum.valid?
  end

#Tests dependency on user presence for forum to be saved
  test 'should not save without user' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.game = @game
      forum.save
      refute forum.valid?
  end

#Tests forum save if invalid by not having a forum entry
  test 'should not save without entry' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.game = @game
      forum.user = @user
      forum.save
      refute forum.valid?
  end

#Tests that forum post has a respective game
  test 'should not save without game' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.user = @user
      forum.save
      refute forum.valid?
  end

#Tests dependent destroy validation in game method
  test 'should destroy forum with game' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.game = @game
      forum.user = @user
      forum.save
      @game.destroy

      refute Forum.exists?(forum.id)
  end


end
