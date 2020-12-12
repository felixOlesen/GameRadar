require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
      @game = games(:one)
      @user = users(:one)
  end

  test 'should not save without title' do
      forum = Forum.new
      forum.user = @user
      forum.entry = 'Forum entry sample'
      forum.save
      refute forum.valid?
  end

  test 'should save valid forum' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.game = @game
      forum.user = @user

      forum.save
      assert forum.valid?
  end

  test 'should not save without user' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.game = @game
      forum.save
      refute forum.valid?
  end

  test 'should not save without entry' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.game = @game
      forum.user = @user
      forum.save
      refute forum.valid?
  end

  test 'should not save without game' do
      forum = Forum.new
      forum.title = 'My Forum'
      forum.entry = 'Forum entry sample'
      forum.user = @user
      forum.save
      refute forum.valid?
  end

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
