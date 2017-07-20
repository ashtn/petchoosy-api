class Pet < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :pet_lists, :through => :pet_lists_pets

  def self.add_pets(user_id, pets, petlist_id)
    new_pets = []
    pets.each do |pet|
      # byebug
      #if pet is not saved
      # if self.is_saved(user_id, pet[:pet_id].to_i, petlist_id).length === 0
        #create a new pet
        new_pet = Pet.create(
        user_id: user_id,
        api_id: pet[:pet_id].to_i,
        fav: pet[:fav], #.fav / .val
        score: pet[:fav] == true ? 10 : 5
        )
        # add pet to array
        new_pets << new_pet
        # else
        #   self.is_saved
      end
      return new_pets
      # create new pet object
      # pet = Pet.create(new_pet)
      # add pet to petlist pets join table
      # self.pets << pet
    # end
  end

  private

  def self.is_saved(user_id, api_id)
    return Pet.where(user_id: user_id, api_id: api_id)
    # byebug
    # Pet.exists?(user_id: user_id, api_id: api_id)
  end

end
