class Forum < ApplicationRecord
  belongs_to :game
  validates :title, :entry, :game, presence: true
end
