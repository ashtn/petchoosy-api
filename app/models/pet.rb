class Pet < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :pet_lists, :through => :pet_lists_pets

  def self.construct(pet_id)
    existing_pet = find_pet(pet_id)
    return existing_pet if existing_pet
    new_pet = Pet.create(
      api_id: pet_id,
    )
    return new_pet
  end
  private

  def self.find_pet(api_id)
    return Pet.find_by(api_id: api_id)
  end

end
