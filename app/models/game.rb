class Game < ApplicationRecord
    validates :name, presence: true
    validates :gb_id, presence: true
    validates :gb_id, uniqueness: true
end
