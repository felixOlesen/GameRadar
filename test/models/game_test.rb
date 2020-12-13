require 'test_helper'

class GameTest < ActiveSupport::TestCase
#Tests name validation for game
  test 'should not save game without name' do
      game = Game.new
      game.gb_id = 0
      game.save
      refute game.valid?
  end

#Tests gb_id presence validation for game
  test 'should not save game without gb_id' do
      game = Game.new
      game.name = 'My Game'
      game.save
      refute game.valid?
  end

#Tests if expected valid game can be saved
  test 'should save valid game' do
     game = Game.new
     game.name = 'My Game'
     game.gb_id = 0
     game.save
     assert game.valid?
  end

#Tests that no two games can have the same gb_id
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

#Tests that the gb_id can only be an integer value
  test 'should not save alphabetical gb_id' do
      game = Game.new
      game.name = 'My Game'
      game.gb_id = 'b'
      game.save
      refute game.valid?
  end

#Tests that the day, month and year values can only be integers
  test 'should not save alphabetical expected date' do
      game = Game.new
      game.name = 'My Game'
      game.gb_id = 0
      game.expected_release_day = 'ba'
      game.expected_release_month = 'tyj'
      game.expected_release_year = '..o8'
      game.save
      refute game.valid?
  end

#Tests that a valid date can be saved for game object
  test 'should save valid expected date' do
      game = Game.new
      game.name = 'My Game'
      game.gb_id = 0
      game.expected_release_day = '20'
      game.expected_release_month = '12'
      game.expected_release_year = '2011'
      game.save
      assert game.valid?
  end

#Tests that day range in validations is working
  test 'should not save invalid day' do
      game = Game.new
      game.name = 'My Game'
      game.gb_id = 0
      game.expected_release_day = '32'
      game.expected_release_month = '12'
      game.expected_release_year = '2011'
      game.save
      refute game.valid?
      game.expected_release_day = '0'
      refute game.valid?
  end

#Tests that month range in validations is working
  test 'should not save invalid month' do
      game = Game.new
      game.name = 'My Game'
      game.gb_id = 0
      game.expected_release_day = '10'
      game.expected_release_month = '13'
      game.expected_release_year = '2011'
      game.save
      refute game.valid?
      game.expected_release_month = '0'
      refute game.valid?
  end

#Tests that year regular expression is working for the year
  test 'should not save invalid year' do
      game = Game.new
      game.name = 'My Game'
      game.gb_id = 0
      game.expected_release_day = '10'
      game.expected_release_month = '13'
      game.expected_release_year = '20110'
      game.save
      refute game.valid?
  end


end
