class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.references :user, foreign_key: true
      t.integer :api_id
      t.boolean :fav
      t.integer :score

      t.timestamps
    end
  end
end
