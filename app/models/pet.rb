class Pet < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :pet_lists, :through => :pet_lists_pets

  def self.add_pets(user_id, pets, petlist_id)
    new_pets = []
    pets.each do |pet|
      existing_pet = self.find_pet(pet[:pet_id].to_i)
      # if pet exists
      if existing_pet
        # add pet to array
        new_pets << existing_pet
        #if pet does not exist
      else
        #create a new pet
        new_pet = Pet.create(
        user_id: user_id,
        api_id: pet[:pet_id].to_i,
        fav: pet[:fav], #.fav / .val
        score: pet[:fav] == true ? 10 : 5
        )
        # add pet to array
        new_pets << new_pet
      end
    end
    return new_pets
  end

  private

  def self.find_pet(api_id)
    return Pet.find_by(api_id: api_id)
  end

end
