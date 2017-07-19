class AddPetListToPets < ActiveRecord::Migration[5.0]
  def change
    add_reference :pets, :pet_list, foreign_key: true
  end
end
