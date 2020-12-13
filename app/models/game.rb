class Game < ApplicationRecord
    #One game can have many forums
    has_many :forums, dependent: :destroy
    #checks fields for presence
    validates :name, :gb_id, presence: true
    #checks that these field can only be integers or null
    validates :gb_id, numericality: {only_integer: true}
    validates :expected_release_day, :expected_release_month, :expected_release_year, numericality: {only_integer: true, allow_nil: true}
    #Allows dates within specified range
    validates :expected_release_day, inclusion: 1..31, allow_nil: true
    validates :expected_release_month, inclusion: 1..12, allow_nil: true
    #ensures that the index is unique
    validates :gb_id, uniqueness: true


end
