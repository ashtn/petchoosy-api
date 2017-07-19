class CreateJoinTablePetListsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :pet_lists do |t|
      t.index [:user_id, :pet_list_id]
      # t.index [:pet_list_id, :user_id]
    end
  end
end
