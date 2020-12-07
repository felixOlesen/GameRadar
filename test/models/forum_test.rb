require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
      @game = games(:one)
      @user = users(:one)
  end

  test 'should not save empty forum' do
      forum = Forum.new
      forum.user = @user
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
end
