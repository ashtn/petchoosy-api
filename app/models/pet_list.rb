class PetList < ApplicationRecord
  # has_many :pets#, :through => :pet_lists_pets
  # has_many :pets, :through => :pet_list_pets
  has_many :pets#, :through => :pet_lists_pet
  has_and_belongs_to_many :users
  # has_and_belongs_to_many :pets
  # has_many :pet_lists_pets #created as a model
  # has_many :pet_list_pets
  has_many :pet_lists_pet
end
