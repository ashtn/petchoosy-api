class PetListsPet < ApplicationRecord
  has_and_belongs_to_many :pets
  has_and_belongs_to_many :pet_lists

  def self.construct(pet_list_id, pet_id)
    PetListsPet.create(
      pet_list_id: pet_list_id,
      pet_id: pet_id,
      score: create_score(pet_id)
    )
  end

  private

  def self.create_score(pet_id)
    return Pet.last == find_pet(pet_id) ? 7 : 5
  end

  def self.find_pet(pet_id)
    return Pet.find_by_id(pet_id)
  end
end
