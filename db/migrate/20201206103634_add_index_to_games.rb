class AddIndexToGames < ActiveRecord::Migration[5.2]
  def change
      add_index :games, :gb_id, unique: true
  end
end
