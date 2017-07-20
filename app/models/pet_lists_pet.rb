class PetListsPet < ApplicationRecord
  has_and_belongs_to_many :pets
  has_and_belongs_to_many :pet_lists
end
