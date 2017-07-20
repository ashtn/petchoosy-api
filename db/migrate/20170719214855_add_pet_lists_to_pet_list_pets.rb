class AddPetListsToPetListPets < ActiveRecord::Migration[5.0]
  def change
    add_reference :pet_list_pets, :pet_list, foreign_key: true
  end
end
