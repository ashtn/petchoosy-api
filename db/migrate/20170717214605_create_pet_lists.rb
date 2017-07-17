class CreatePetLists < ActiveRecord::Migration[5.0]
  def change
    create_table :pet_lists do |t|
      t.references :user_group, foreign_key: true

      t.timestamps
    end
  end
end
