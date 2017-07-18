class PetList < ApplicationRecord
  belongs_to :user_group
  has_many :pets
end
