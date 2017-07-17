class CreatePetListInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :pet_list_interests do |t|
      t.references :user, foreign_key: true
      t.string :animal
      t.string :breed
      t.string :size
      t.string :sex
      t.integer :location
      t.string :age

      t.timestamps
    end
  end
end
