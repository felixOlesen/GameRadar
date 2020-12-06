class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.text :deck
      t.datetime :og_release_date
      t.integer :expected_release_day
      t.integer :expected_release_month
      t.integer :expected_release_year
      t.string :platforms
      t.string :image
      t.integer :gb_id

      t.timestamps
    end
  end
end
