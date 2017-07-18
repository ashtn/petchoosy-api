class PetListsPets < ActiveRecord::Migration[5.0]
  def change
    create_table :pet_lists_pets, :id => false do |t|
      t.integer :pet_id
      t.integer :pet_list_id
    end
  end
end
