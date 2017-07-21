class AddPetsToPetListsPets < ActiveRecord::Migration[5.0]
  def change
    add_reference :pet_lists_pets, :pet, foreign_key: true
  end
end
