class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.belongs_to :game, foreign_key: true, index: true, null: false
      t.string :title, null: false
      t.text :entry, null: false

      t.timestamps null: false
    end
  end
end
