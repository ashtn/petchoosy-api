class RemoveFavAndScoreFromPets < ActiveRecord::Migration[5.0]
  def change
    remove_column :pets, :fav, :boolean
    remove_column :pets, :score, :integer
  end
end
