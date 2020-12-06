require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should not save empty game' do
      game = Game.new
      game.save
      refute game.valid?
  end

  test 'should save valid game' do
     game = Game.new
     game.name = 'My Game'
     game.gb_id = 0
     game.save
     assert game.valid?
  end

  test 'should not save duplicate game gb_id' do
      game1 = Game.new
      game1.name = 'My Game'
      game1.gb_id = 0
      game1.save

      game2 = Game.new
      game2.name = 'My Game'
      game2.gb_id = 0
      game2.save
      refute game2.valid?
  end

end
