class Forum < ApplicationRecord
#one game can have many forums
  belongs_to :game
#one user can have many forums
  belongs_to :user
# ensures that these fields are not null
  validates :title, :entry, :game, presence: true
end
