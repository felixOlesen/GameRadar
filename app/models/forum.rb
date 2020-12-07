class Forum < ApplicationRecord
  belongs_to :game
  belongs_to :user
  validates :title, :entry, :game, presence: true
end
