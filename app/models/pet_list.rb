class PetList < ApplicationRecord
  # has_many :pets#, :through => :pet_lists_pets
  # has_many :pets, :through => :pet_list_pets
  has_many :pets#, :through => :pet_lists_pet
  has_and_belongs_to_many :users
  # has_and_belongs_to_many :pets
  # has_many :pet_lists_pets #created as a model
  # has_many :pet_list_pets
  has_many :pet_lists_pet

  def self.get_pets(pet_list)
    pets_data = []
    pets = pet_list.pet_lists_pet

    pets.each do |pet_list_pet|
      # get pet by pet_id
      pet = Pet.find(pet_list_pet.id)

      # get pet data from api
      pet_data = PetFinderWrapper.get_pet(pet.api_id)

      # add response to array
      pets_data << pet_data
    end
    
    # return array
    return pets_data
  end
end
