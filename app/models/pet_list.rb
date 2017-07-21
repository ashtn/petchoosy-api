class PetList < ApplicationRecord


  has_many :pets#, :through => :pet_lists_pet
  has_and_belongs_to_many :users

  has_many :pet_lists_pet

  def self.construct_pet_list_pet(pet_list_id, pet_id)
      return PetListsPet.construct(pet_list_id, pet_id)
  end

  def self.get_pets_data(pet_list)
    pets_data = []
    pets = pet_list.pet_lists_pet

    pets.each do |pet_list_pet|
      # get pet by pet_id
      pet = Pet.find(pet_list_pet.pet_id)

      # get pet data from api
      pet_data = PetFinderWrapper.get_pet(pet.api_id)

      # add response to array
      pets_data << pet_data
    end

    # return array
    return pets_data
  end

  def self.get_pet(api_id)
      return Pet.get_pet(api_id)
  end

  def self.get_pet_lists_pet(pet_list_id, pet_id)
    puts "pet_list_id: #{pet_list_id} | pet_id: #{pet_id}"
    return PetListsPet.find_by_pet_list_id_and_pet_id( pet_list_id, pet_id)

  end
end
