class CreatePetListsPets < ActiveRecord::Migration[5.0]
  def change
    create_table :pet_lists_pets do |t|
      t.integer :score

      t.timestamps
    end
  end
end
