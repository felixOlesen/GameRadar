class Game < ApplicationRecord
    has_many :forums, dependent: :destroy
    validates :name, :gb_id, presence: true
    validates :gb_id, uniqueness: true
end
