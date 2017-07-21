class Pet < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :pet_lists, :through => :pet_lists_pets
  validates :api_id, uniqueness: true, presence: true

  def self.get_pet(api_id)
    existing_pet = find_pet(api_id)

    if !existing_pet
      existing_pet = Pet.create(api_id: api_id)
    end

    return existing_pet
  end

  private

  def self.find_pet(api_id)
    return Pet.find_by(api_id: api_id)
  end

end
