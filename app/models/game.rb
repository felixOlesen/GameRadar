class Game < ApplicationRecord
    has_many :forums, dependent: :destroy
    validates :name, :gb_id, presence: true
    validates :gb_id, numericality: {only_integer: true}
    validates :expected_release_day, :expected_release_month, :expected_release_year, numericality: {only_integer: true, allow_nil: true}
    validates :expected_release_day, inclusion: 1..31, allow_nil: true
    validates :expected_release_month, inclusion: 1..12, allow_nil: true
    validates :gb_id, uniqueness: true


end
