class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.integer :api_id

      t.timestamps
    end
  end
end
